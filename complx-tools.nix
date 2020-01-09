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
in stdenv.mkDerivation (rec {
  name = "complx-tools";
  # http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/pool/main/c/complx-tools/complx-tools_4.18.2.orig.tar.bz2
  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "complx";
    rev = "c6df9a46470c5ba6e7e84dcdad3c3d2b76d2a9d6";
    sha256 = "1mh2pkl9f1hrsdgsx0xk1bcv390ld7pdcbzq6y0330b4xp3yfbqh";
  };
  nativeBuildInputs = [
    cmake
    pkgconfig
  ];
  buildInputs = [
    boost
    wxGTK31
    glib
    pcre
  ];
} // lib.optionalAttrs createDesktop {
  inherit desktopItem;
  postInstall = ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
})
