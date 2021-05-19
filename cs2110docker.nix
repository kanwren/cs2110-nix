{ substituteAll
, runtimeShell
, docker
}:

substituteAll {
  name = "cs2110docker";
  src = ./res/cs2110docker.sh;
  inherit runtimeShell docker;
  dir = "bin";
  isExecutable = true;
  description = "Run the CS 2110 Docker container";
}
