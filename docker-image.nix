{ dockerTools
}:

dockerTools.pullImage {
  imageName = "gibrane/cs2110docker";
  imageDigest = "sha256:2cd8a9d12b96b03e1b0357326288006e326eeab6e5645780a40518ce1e0aac80";
  finalImageName = "gibrane/cs2110docker";
  finalImageTag = "latest";
  sha256 = "0s0vjlxmpjb3wr7z3jjhv8n5hxgnj6avkpp2dw9alpvs5vcs820k";
  os = "linux";
  arch = "amd64";
}
