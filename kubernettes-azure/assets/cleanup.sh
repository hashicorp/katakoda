#!/bin/bash

# run on exit to clean up terraform
function exit() {
  if [ -f ./terraform.tfstate ]; then
    terraform destroy -force
  fi
}

trap exit SIGTERM

while :; do sleep 1; done
