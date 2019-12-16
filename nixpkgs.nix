let
  fetchNixpkgs = { owner, repo, rev, sha256 }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };
in

fetchNixpkgs {
  owner = "nixos";
  repo = "nixpkgs";
  rev = "3ad650a14b0477a0df2795abe185c66849a5012d";
  sha256 = "06g6frrs8l9p19kb8jz38fmpcckfqkqzk6kxd10kz5497h22ai9b";
}
