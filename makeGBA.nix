# A builder for GBA assignments

{ stdenv
, makeWrapper, cmake
, mednafen, gcc-arm-embedded
, cs2110-vbam-sdl, cs2110-gba-linker-script, nin10kit
}:

{ src                       # the directory containing the Makefile
, name ? baseNameOf src     # the name of the derivation to build
, executableName            # the name of the executable to produce
, gbaName ? executableName  # the name of the .gba file produced
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

  inherit src;
  configurePhase = "mkdir -p $out";

  buildPhase = ''
    ARMINC="${gcc-arm-embedded}/arm-none-eabi/include" \
    ARMLIB="${gcc-arm-embedded}/arm-none-eabi/lib" \
    GCCLIB=${gcc-arm-embedded}/lib/gcc/arm-none-eabi/$(arm-none-eabi-gcc -dumpversion) \
    LINKSCRIPT_DIR=${cs2110-gba-linker-script} \
    make ${builtins.toString targets}
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    mv "mednafen-09x.cfg" "$out"
    mv "${gbaName}.gba" "$out"

    makeWrapper \
      "${mednafen}/bin/mednafen" \
      "$out/bin/${executableName}" \
      --set MEDNAFEN_HOME "$out" \
      --add-flags "$out/${gbaName}.gba"
  '';
};
in drv.overrideAttrs (_: attrs)

