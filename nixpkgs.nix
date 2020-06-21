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
  rev = "3d746848477b0ee2173ac3039a59a8499ef73904";
  sha256 = "05ciia6sfs6ybkm2agclpmsvjxf36whisgpdcd044ia6gxm18sq4";
}
