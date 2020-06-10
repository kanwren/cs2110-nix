{ dockerTools
}:

dockerTools.pullImage {
  imageName = "gibrane/cs2110docker";
  imageDigest = "sha256:5470866eee66ba67f93fa4011476ac0757ed5202b879605003b49f6734e3b42f";
  sha256 = "0wrqslyddw4dvnfhq4z0add9p54pc58hq7jh6xp1m1hnrsps3bz5";

  finalImageName = "gibrane/cs2110docker";
  finalImageTag = "latest";

  os = "linux";
  arch = "amd64";
}
