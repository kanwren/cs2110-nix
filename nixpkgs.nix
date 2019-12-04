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
  rev = "c768e2338f948d7cf0fc37e0bbfa9acec4b07bfa";
  sha256 = "1156qpbhh0xxlwq9ai0pkhapczjm5d2ajwr5j3fr0j3yb9giw1av";
}
