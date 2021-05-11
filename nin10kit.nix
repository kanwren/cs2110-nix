{ stdenv, lib, fetchFromGitHub, makeWrapper
, makeDesktopItem
, cmake, pkgconfig
, wxGTK31, imagemagick7
, createDesktop ? true
}:

let
  pname = "nin10kit";
  version = "1.7";
  desktopItem = makeDesktopItem {
    name = pname;
    exec = "nin10kitgui";
    desktopName = pname;
    genericName = pname;
  };
in stdenv.mkDerivation ({
  inherit pname version;

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ wxGTK31 imagemagick7 ];

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "nin10kit";
    rev = "104309a680355da166074c54c988f9d17b9aee16";
    sha256 = "0p0wdv45iqvablhy4wadwy0v45xk740mw26pr3z7ylpqazpj5s9f";
  };

  cmakeFlags = [ "-DENABLE_MAGICK7_SUPPORT=ON" ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp nin10kit "$out/bin"
    cp nin10kitgui "$out/bin"
  '' + lib.optionalString createDesktop ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
} // lib.optionalAttrs createDesktop { inherit desktopItem; })

