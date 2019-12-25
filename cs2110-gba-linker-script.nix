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

{ stdenv }:

stdenv.mkDerivation {
  name = "cs2110-gba-linker-script";
  src = (builtins.fetchTarball {
    url = "http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/pool/main/c/cs2110-gba-linker-script/cs2110-gba-linker-script_1.1.2.orig.tar.bz2";
    sha256 = "1nkid5n43h75nqa8acg9p91mpd0bbqn7nhsp0fbm6xmlad13231c";
  });

  # The tools assume where they're going to be installed by apt, and where
  # library dependencies are, so we have to modify the source code in order to
  # be able to override those environment variables with information from nix
  buildPhase = ''
    sed -i "s/LINKSCRIPT_DIR =/LINKSCRIPT_DIR ?=/g" cs2110-tools/GBAVariables.mak
    sed -i "s/ARMINC =/ARMINC ?=/g" cs2110-tools/GBAVariables.mak
    sed -i "s/ARMLIB =/ARMLIB ?=/g" cs2110-tools/GBAVariables.mak
    sed -i "s/GCCLIB =/GCCLIB ?=/g" cs2110-tools/GBAVariables.mak
  '';

  installPhase = ''
    mkdir -p "$out"
    mv cs2110-tools/* "$out"
  '';
}
