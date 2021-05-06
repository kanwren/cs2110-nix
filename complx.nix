{ stdenv, lib
, runCommand, makeWrapper
, fetchFromGitHub
, makeDesktopItem
, cmake, pkgconfig
, boost, wxGTK31, glib, pcre
# Whether or not to create a desktop file
, createDesktop ? true
# Old complx looks pretty bad with dark GTK themes, so give the option to
# disable it altogether
, disableGTK ? false
}:

let
  desktopItem = makeDesktopItem {
    name = "complx";
    exec = "complx";
    desktopName = "Complx";
    genericName = "Complx";
  };

  complx = stdenv.mkDerivation (rec {
    pname = "complx";
    version = "4.19.2";

    src = fetchFromGitHub {
      owner = "TricksterGuy";
      repo = "complx";
      rev = version;
      sha256 = "sha256-KjMPxBpeFOf3PW2mvZfWs8lKFGN/5IMMAeRD+EisiDY=";
    };

    nativeBuildInputs = [ cmake pkgconfig ] ++ lib.optionals disableGTK [ makeWrapper ];
    buildInputs = [ boost wxGTK31 glib pcre ];

    postInstall = lib.optionalString disableGTK ''
      wrapProgram "$out"/bin/complx --unset XDG_DATA_DIRS
    '';

    meta = with lib; {
      homepage = "https://github.com/TricksterGuy/complx";
      description = "Extensible LC-3 simulator (GUI and CLI), assembler, and autograder/test framework";
      license = licenses.gpl3;
    };
  });

  complxWithDesktop = if !createDesktop then complx else complx.overrideAttrs (old: {
    inherit desktopItem;

    postInstall = (old.postInstall or "") + ''
      mkdir -p "$out/share/applications"
      cp ${desktopItem}/share/applications/* "$out/share/applications"
    '';
  });
in complxWithDesktop

