{ stdenv
, cmake
, zlib, libpng, glfw3, SDL
}:

stdenv.mkDerivation {
  name = "cs2110-vbam-sdl";
  nativeBuildInputs = [ cmake ];
  buildInputs = [
    zlib
    libpng
    glfw3
    SDL
  ];
  # TODO: switch to fetchFromGitHub
  src = builtins.fetchTarball {
    url = "http://ppa.launchpad.net/tricksterguy87/ppa-gt-cs2110/ubuntu/pool/main/c/cs2110-vbam/cs2110-vbam_1.5.5-0ubuntu1~ppa1~bionic1.tar.gz";
    sha256 = "0lrbnwxkxsjryynvr18lgf7wgi39hlvmkl86wvnc55h2lrk22a8a";
  };
  installPhase = ''
    mkdir -p "$out/bin"
    mv vbam "$out/bin"
  '';
}

