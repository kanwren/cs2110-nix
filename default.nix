# Derivations for the tooling used in CS 2110 at Georgia Tech.
# Most of the tooling was made by Brandon, so dependencies are mainly fetched
# from his GitHub or from his PPA at
# http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/

{ pkgs ? let nixpkgs = import ./nixpkgs.nix; in import nixpkgs {}
}:

rec {
  # The cs2110 docker image itself
  docker-image = pkgs.callPackage (import ./docker-image.nix) {};

  # Wrapper script to manage the cs2110 docker image
  # Override enableDockerMachine to true if you're using docker-machine with a
  # non-localhost default IP
  cs2110docker = pkgs.callPackage (import ./cs2110docker.nix) {
    inherit docker-image;
  };

  complx-tools = pkgs.callPackage (import ./complx-tools.nix) {};

  cs2110-gba-linker-script = pkgs.callPackage (import ./cs2110-gba-linker-script.nix) {};
  cs2110-vbam-sdl = pkgs.callPackage (import ./cs2110-vbam-sdl.nix) {};
  nin10kit = pkgs.callPackage (import ./nin10kit.nix) {};

  makeGBA = pkgs.callPackage (import ./makeGBA.nix) {
    inherit cs2110-vbam-sdl cs2110-gba-linker-script nin10kit;
  };

  # Basic environment for homework hacking
  env = pkgs.mkShell {
    buildInputs = with pkgs; [
      cmake
      gcc
      gdb
      valgrind

      complx-tools
      cs2110-vbam-sdl
      nin10kit
    ];
  };

}

