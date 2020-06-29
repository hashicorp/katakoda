#!/usr/bin/env bash
# shellcheck disable=SC2143

export log_dir="/root/.log"

if [[ $(docker ps -f name=vtl-splunk --format "{{.Status}}" | grep -w healthy) ]]
then
  echo "done"
else
  echo "Splunk container is not healthy. Please ensure it is up and healthy before continuing." >> "$log_dir"/01-start-containers.log 2>&1
fi
