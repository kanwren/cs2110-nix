# Use mednafen 0.9.48
self: super:

let
  fetchNixpkgs = { rev, sha256 }: builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256;
  };
  pinned-pkgs = import (fetchNixpkgs {
    rev = "2158ec610d90359df7425e27298873a817b4c9dd";
    sha256 = "1gf80xbsi5fa0wjam8aa0bq89ynnm9wsb3n6s9nzg9f6kqd6a0q7";
  }) {};
in {
  inherit (pinned-pkgs) mednafen;
}

