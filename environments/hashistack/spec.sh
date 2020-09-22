#!/bin/bash -x

export SCRIPT_DIR="${0%/*}"
export TARGET="katacoda"
export HTML_REPORT="/tmp/inspec-$RANDOM$$.html"

cd "$SCRIPT_DIR"

function setup () {
  # Get execution container
  docker pull chef/inspec

  # Check if target container is running
  declare -xi TARGET_RUNNING=$(
  			docker ps |
  				grep -c ${TARGET:?})

  # Build container based on current scripts
  if [[ ${TARGET_RUNNING} == 0 ]] ; then
    make
  fi
}

# Socket allows Docker API targets
function inspec () {
   docker run \
       -it \
       --rm \
      --env CHEF_LICENSE='accept-silent' \
      --volume /var/run/docker.sock:/var/run/docker.sock \
      --volume "$PWD":/share \
      --volume /tmp:/tmp \
      chef/inspec \
       "$@"
}

# Setup our dependencies
setup

# Execute the tests
inspec exec "${SCRIPT_DIR:?}"/controls/*.rb \
  --target=docker://${TARGET:?} \
  --reporter cli html:"${HTML_REPORT:?}" \
  --log-level=debug \
  --show-progress

declare -i EXIT_CODE=$?

[ -f "$HTML_REPORT" ] && open "$HTML_REPORT"

# Cleanup
make clean

exit ${EXIT_CODE:?}
