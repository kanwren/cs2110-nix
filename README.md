# cs2110-nix

Nix derivations for the CS 2110 toolchain

### Usage

Fetch via regular means. For example, here's a basic environment for working on
homeworks:

```nix
let
  pkgs = import <nixpkgs> {};
  cs2110pkgs = import (pkgs.fetchFromGitHub {
    owner = "nprindle";
    repo = "cs2110-nix";
    rev = "...";
    sha256 = "...";
  }) {};
in pkgs.mkShell {
  buildInputs = (with pkgs; [
    cmake
    gcc
    gdb
    valgrind
  ]) ++ (with cs2110pkgs; [
    complx-tools
    cs2110-vbam-sdl
    nin10kit
    CircuitSim
    cs2110docker
  ]);

  # See note in cs2110-gba-linker-script.nix for why this is important
  shellHook = ''
    export LINKSCRIPT_DIR="${cs2110pkgs.cs2110-gba-linker-script}"
  '';
}
```

Currently, the following things are provided:
- `docker-image`: The docker image itself. You can build it and load it with `docker load < result`.
- `cs2110docker`: A wrapper of `cs2110docker.sh`, except installed into your environment.
    - This assumes you're on Linux by default, and don't need to look up the IP
      of your `docker-machine`. If you do, override it:

```nix
cs2110pkgs.cs2110docker.override { enableDockerMachine = true; }
```

- `CircuitSim`: A wrapper application for running a CS2110-compliant
  `CircuitSim.jar`. It will run it using the correct Java version and set the
  necessary GTK environment variables.
- `complx-tools`: Complx, for LC-3
- `cs2110-gba-linker-script`: Some files for building GBA games. Note that
  normal 2110 Makefiles assume they're in the Docker container, and so use an
  absolute path to these files. See the note in `cs2110-gba-linker-script.nix`
  for how to fix this.
- `cs2110-vbam-sdl`: vba-m, the old emulator we used to use
- `nin10kit`: nin10kit, utilities for making GBA games
- `makeGBA`: A function to make building CS2110 GBA games with nix easier

