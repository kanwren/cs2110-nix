{ stdenv, lib, fetchFromGitHub
, makeDesktopItem
, cmake, pkgconfig
, boost, wxGTK31, glib, pcre
, createDesktop ? true
}:

let
  desktopItem = makeDesktopItem {
    name = "complx";
    exec = "complx";
    desktopName = "Complx";
    genericName = "Complx";
  };
in stdenv.mkDerivation rec {
  pname = "complx-tools";
  version = "unstable_2021-02-22";

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "complx-tools";
    rev = "c6188fb81b63a805bb27d5b7104ce8346f79240a";
    sha256 = "sha256-5bdzASkEHxIh8g4d0JcOzbMiaSeM9snx/8RVIrkRszQ=";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ wxGTK31 glib ];

  fixupPhase = ''
    mkdir -p "$out"/bin
    mv "$out"/complx "$out"/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/TricksterGuy/complx";
    description = "Extensible LC-3 simulator (GUI and CLI), assembler, and autograder/test framework";
    license = licenses.gpl3;
  };

} // lib.optionalAttrs createDesktop {
  inherit desktopItem;
  postInstall = ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
}
