# This is an annoying dependency; it's just a directory with some files used in
# the Makefiles when building GBA projects. However, the Makefiles assume it's
# going to be installed to /opt/cs2110-tools, so we have to override the
# environment variables with the proper paths in the nix environment.
#
# In order to run 'make' with most Makefiles the TAs provide, we need the
# following environment variables to be overridden:
#   ARMINC="${gcc-arm-embedded}/arm-none-eabi/include"
#   ARMLIB="${gcc-arm-embedded}/arm-none-eabi/lib"
#   GCCLIB=${gcc-arm-embedded}/lib/gcc/arm-none-eabi/$(arm-none-eabi-gcc -dumpversion)
#   LINKSCRIPT_DIR=${cs2110-gba-linker-script}
# Make sure that the Makefile uses an overridable LINKSCRIPT_DIR instead of
# hardcoding /opt/cs2110-tools

{ stdenv
, runCommandNoCCLocal
, gcc-arm-embedded
, binutils, gnutar
}:

stdenv.mkDerivation {
  name = "cs2110-gba-linker-script";
  src = runCommandNoCCLocal "extract-linker-script" { buildInputs = [ binutils gnutar ]; } ''
    mkdir -p "$out"
    ar x --output="$out" ${./res/cs2110-gba-linker-script_1.1.2-0.deb}
  '';

  propagatedBuildInputs = [ gcc-arm-embedded ];

  installPhase = ''
    tar xvf data.tar.xz
    mkdir -p "$out"
    mv opt/cs2110-tools/* "$out"
  '';

  # The tools assume where they're going to be installed by apt, and where
  # library dependencies are, so we have to modify the source code in order to
  # be able to override those environment variables with information from nix
  fixupPhase = ''
    sed -i '
      s@^LINKSCRIPT_DIR =@LINKSCRIPT_DIR ?=@g;
      s@^ARMINC *=.*$@ARMINC ?= ${gcc-arm-embedded}/arm-none-eabi/include@g;
      s@^ARMLIB *=.*$@ARMLIB ?= ${gcc-arm-embedded}/arm-none-eabi/lib@g;
      s@^GCCLIB *=.*$@GCCLIB ?= ${gcc-arm-embedded}/lib/gcc/arm-none-eabi/'"$(arm-none-eabi-gcc -dumpversion)"'@g;
    ' "$out/GBAVariables.mak"
  '';
}
