{ dockerTools
}:

dockerTools.pullImage {
  imageName = "gtcs2110/cs2110docker";
  imageDigest = "sha256:7ed392a216f4ee6bc9351b8edeb69fd414c2d15ef530800709fbaa284f84b1eb";
  sha256 = "0v7dc3ibrhhlc2j2pnj57si46mi9m50qg0qcqzf0bs1cas2ffgxc";

  finalImageName = "gtcs2110/cs2110docker";

  os = "linux";
  arch = "amd64";
}
