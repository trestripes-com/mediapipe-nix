{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
          config.allowUnfree = true;
        };
        python-env = pkgs.python3.withPackages (p: with p; [
          numpy
        ]);
      in
      {
        packages = rec {
          mediapipe = pkgs.python3.pkgs.callPackage ./mediapipe.nix { };
          default = mediapipe;
        };
      });
}
