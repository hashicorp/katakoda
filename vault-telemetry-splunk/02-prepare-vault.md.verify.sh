#!/usr/bin/env bash
# shellcheck disable=SC2143

export log_dir="/root/.log"

if docker ps -f name=vtl-vault --format "{{.Status}}" | grep -q healthy
  then
    echo "done"
  else
    echo "Vault server container is not healthy. Please ensure it is healthy, and that you have initialized and unsealed it before continuing."  >> "$log_dir"/02-init-and-unseal.log 2>&1
fi


if vault status -format=json | jq -r '.initialized' | grep -q true
  then
    echo "done"
  else
    echo "Vault server is not initialized. Please initialize it, unseal it, and login before continuing."  >> "$log_dir"/02-init-and-unseal.log 2>&1
fi


if vault token lookup -format=json | jq -r '.data.policies[0]' | grep -q root
  then
    echo "done"
  else
    echo "Vault token does not contain root policy; you need to login with the initial root token before continuing." >> "$log_dir"/02-init-and-unseal.log 2>&1
fi
