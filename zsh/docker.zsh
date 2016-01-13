# I use tmux, and am constantly starting and terminating shells.
# Typing eval "$(docker-machine env default)" before being able to use docker is a PITA
# So this intercepts the call to /usr/local/bin/docker, detects whether we're setup to use
# the docker-machine environment, and then dispatches to docker
DOCKER_EXECUTABLE=/usr/local/bin/docker

docker() {
  if [ -z "$DOCKER_MACHINE_NAME" ]; then
    eval "$(docker-machine env default)"
  fi

  $DOCKER_EXECUTABLE "$@"
}
