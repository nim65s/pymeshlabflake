{
  description = "Building pymeshlab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pymeshlab = pkgs.libsForQt5.callPackage ./pymeshlab.nix {};
      in
      {
        packages.default = pymeshlab;
        devShells.default = pkgs.mkShell { inputsFrom = [ pymeshlab ]; };
      }
    );
}
