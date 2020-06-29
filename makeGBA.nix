# A builder for GBA assignments

{ stdenv, lib
, makeWrapper, cmake
, mednafen, gcc-arm-embedded
, cs2110-vbam-sdl, cs2110-gba-linker-script, nin10kit
}:

{ src                       # the directory containing the Makefile
, name                      # the name of the derivation to build
, executableName ? name     # the name of the executable to produce
, gbaName ? executableName  # the name of the .gba file produced
, cfgFile ? null            # .cfg file for mednafen to use
, targets ? []              # make targets
, attrs ? {}                # attributes to override in stdenv.mkDerivation
}:

let drv = stdenv.mkDerivation {
  inherit name;

  buildInputs = [
    makeWrapper

    cmake
    mednafen
    gcc-arm-embedded

    cs2110-vbam-sdl
    cs2110-gba-linker-script
    nin10kit
  ];

  src = lib.cleanSource src;
  configurePhase = "true";

  buildPhase = ''
    make ${builtins.toString targets} LINKSCRIPT_DIR=${cs2110-gba-linker-script}
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    ${lib.optionalString (cfgFile != null) ("cp ${cfgFile} \"$out/mednafen-09x.cfg\"")}
    mv "${gbaName}.gba" "$out"

    makeWrapper \
      "${mednafen}/bin/mednafen" \
      "$out/bin/${executableName}" \
      --set MEDNAFEN_HOME "$out" \
      --add-flags "$out/${gbaName}.gba"
  '';
};
in drv.overrideAttrs (_: attrs)

