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

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "complx";
    rev = "40d07c6282e7d84d8ab77d0e1e4dd05dbac8d29d";
    sha256 = "1fac9zakj1h31p7jmlxk3xkjcj4a1yyvag5lgkhqm0c9r5bllafa";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ boost wxGTK31 glib pcre ];

} // lib.optionalAttrs createDesktop {
  inherit desktopItem;
  postInstall = ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
})
