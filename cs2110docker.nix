{ docker-image
, docker
, writeShellScriptBin
, enableDockerMachine ? false
, docker-machine
}:

let
  findDefaultIp =
    if enableDockerMachine
    then ''
      ipaddress="$(${docker-machine}/bin/docker-machine ip default 2>/dev/null)"
      foundip=$?
      if [ $foundip -ne 0 ]; then
        ipaddress="localhost"
      fi
    ''
    else ''
      ipaddress="localhost"
    '';
in writeShellScriptBin "cs2110docker" ''
  imageName="${docker-image.imageName}"
  existingContainers=$(${docker}/bin/docker ps -a | grep "$imageName" | awk '{print $1}')

  if [ -n "$existingContainers" ]; then
    echo "Found CS 2110 containers. Stopping and removing them."
    ${docker}/bin/docker stop $existingContainers >/dev/null
    ${docker}/bin/docker rm $existingContainers >/dev/null
  fi

  if [ "$1" = "stop" ]; then
    if [ -n "$existingContainers" ]; then
      echo "Successfully stopped CS 2110 containers."
    else
      echo "No existing CS 2110 containers."
    fi
  else

    dockerImages-$(${docker}/bin/docker image ls | grep "$imageName" | awk '{print $1}')
    if [ -n "$dockerImage" ]; then
      echo "Loading ${docker-image.imageName}"
      ${docker}/bin/docker load -i ${docker-image}
    else
      echo "Docker image loaded"
    fi

    if [ $? -ne 0 ]; then
      >&2 echo "Failed to load ${docker-image.imageName}"
      exit 1
    fi

    echo "Starting up new CS 2110 Docker Container:"
    if [ "$1" = "-it" ]; then
      ${docker}/bin/docker run --rm -p 6901:6901 -p 5901:5901 -v "$(pwd)":/cs2110/host/ --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it  --entrypoint /bin/bash "$imageName"
    else
      ${docker}/bin/docker run -d -p 6901:6901 -p 5901:5901 -v "$(pwd)":/cs2110/host/ --cap-add=SYS_PTRACE --security-opt seccomp=unconfined "$imageName"

      successfulRun=$?

      ${findDefaultIp}

      if [ $successfulRun -eq 0 ]; then
        echo "Successfully launched CS 2110 Docker container. Please go to http://$ipaddress:6901/vnc.html to access it."
      else
        echo "ERROR: Unable to launch CS 2110 Docker container."
      fi
    fi
  fi
''
