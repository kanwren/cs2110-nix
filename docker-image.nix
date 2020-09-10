{ dockerTools
}:

dockerTools.pullImage {
  imageName = "gtcs2110/cs2110docker";
  imageDigest = "sha256:7ed392a216f4ee6bc9351b8edeb69fd414c2d15ef530800709fbaa284f84b1eb";
  sha256 = "04dfjlm0bg6n4bxb7hdn08563pgh4da5yh54r5rk39zzcgrlv0an";

  finalImageName = "gtcs2110/cs2110docker";

  os = "linux";
  arch = "amd64";
}
