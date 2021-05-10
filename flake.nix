{
  description = "Nix derivations for the Georgia Tech CS 2110 toolchain";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
    }) // {
      overlay = pkgs-self: pkgs-super: {
        cs2110 = import ./default.nix { pkgs = pkgs-self; };
      };
    };
}
