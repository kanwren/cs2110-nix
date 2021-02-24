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
  pname = "complx";
  version = "4.19.0";

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "complx";
    rev = version;
    sha256 = "037saps2knqvdc7lvrba3qdfqcbjskqcvxmqc2lppcrvshsg5w3m";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ boost wxGTK31 glib pcre ];

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
