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
  pname = "complx-tools";
  version = "unstable_2021-05-02";

  src = fetchFromGitHub {
    owner = "TricksterGuy";
    repo = "complx-tools";
    rev = "8c496ffdf9c173d3a89558e739aafa9a9931d5d3";
    sha256 = "sha256-hpib7ZXM0Qlb4wS3TOww4xAJ+j6nKJzG4A/IHFmTQEA=";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ wxGTK31 glib ];

  fixupPhase = ''
    mkdir -p "$out"/bin
    mv "$out"/complx "$out"/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/TricksterGuy/complx-tools";
    description = "Extensible LC-3 simulator (GUI and CLI), assembler, and autograder/test framework";
    license = licenses.gpl3;
  };
} // lib.optionalAttrs createDesktop {
  inherit desktopItem;
  postInstall = ''
    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* "$out/share/applications"
  '';
})
