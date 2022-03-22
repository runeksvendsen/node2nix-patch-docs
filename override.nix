{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem}:

let
  nodePackages = import ./default.nix {
    inherit pkgs;
  };
in
{
  nodePackages = nodePackages;

  newNodePackages = nodePackages // {
    bufferutil = nodePackages.bufferutil.override {
      preRebuild = ''
        wrapProgram $out/bin/dnschain --suffix PATH : ${pkgs.openssl.bin}/bin
      '';
    };
  };
}

