{ stdenv, lib, fetchFromGitHub, makeWrapper
, makeDesktopItem
, cmake, pkgconfig
, wxGTK31, imagemagick
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
  buildInputs = [ wxGTK31 imagemagick ];

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "nin10kit";
    rev = "dbf81c62c0fa2f544cfd22b1f7d008a885c2b589";
    sha256 = "1z3kfxqvakx7wkwwcjw1nmp3lg121a56bcw5g1sh9kvmmi2az4fl";
  };

  installPhase = ''
    mkdir -p "$out/bin"
    cp nin10kit "$out/bin"
    cp nin10kitgui "$out/bin"
  '' + lib.optionalString createDesktop ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
} // lib.optionalAttrs createDesktop { inherit desktopItem; })

