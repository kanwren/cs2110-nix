{ dockerTools
}:

dockerTools.pullImage {
  imageName = "gibrane/cs2110docker";
  imageDigest = "sha256:e820a8f85fbfca62e9b7e6128e1ddcc2bf709117f51bc94d53b95ad6a72ac594";
  sha256 = "1dqrdd7m45abhchxr907l487j1sqy2sf3jprbqrh25f534d7apd8";
  finalImageName = "gibrane/cs2110docker";
  os = "linux";
  arch = "amd64";
}
