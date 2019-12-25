{ stdenv, fetchFromGitHub
, cmake, pkgconfig
, wxGTK31, imagemagick
}:

stdenv.mkDerivation {
  name = "nin10kit";
  nativeBuildInputs = [
    cmake
    pkgconfig
  ];
  buildInputs = [
    wxGTK31
  ];
  propagatedBuildInputs = [
    imagemagick
  ];
  # http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/pool/main/n/nin10kit/nin10kit_1.7.1.orig.tar.bz2
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
  '';
}

