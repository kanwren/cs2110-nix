# Derivations for the tooling used in CS 2110 at Georgia Tech.
# Most of the tooling was made by Brandon, so dependencies are mainly fetched
# from his GitHub or from his PPA at
# http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/

{ pkgs ? let nixpkgs = import ./nixpkgs.nix; in import nixpkgs {}
}:

{
  complx-tools = import ./complx-tools.nix { inherit pkgs; };
  cs2110-gba-linker-script = import ./cs2110-gba-linker-script.nix { inherit pkgs; };
  cs2110-vbam-sdl = import ./cs2110-vbam-sdl.nix { inherit pkgs; };
  nin10kit = import ./nin10kit.nix { inherit pkgs; };
}

