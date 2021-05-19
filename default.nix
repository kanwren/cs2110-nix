# Derivations for the tooling used in CS 2110 at Georgia Tech.
# Most of the tooling was made by Brandon, so dependencies are mainly fetched
# from his GitHub or from his PPA at
# http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/

{ pkgs
}:

rec {
  # Wrapper script to manage the cs2110 docker image
  cs2110docker = pkgs.callPackage ./cs2110docker.nix {};

  # CS2110-compliant version of CircuitSim
  CircuitSim = pkgs.callPackage ./circuitsim.nix {};

  # Complx, for LC-3
  complx = pkgs.callPackage ./complx.nix {};
  complx-tools = pkgs.callPackage ./complx-tools.nix {};

  # Tools used for building GBA games
  cs2110-gba-linker-script = pkgs.callPackage ./cs2110-gba-linker-script.nix {};
  # nin10kit, utilities for making GBA games
  nin10kit = pkgs.callPackage ./nin10kit.nix {};
}

