#!/usr/bin/env bash

printf "Completing Terraform installation"

while [ ! -x /usr/local/bin/terraform ]; do
  sleep 2
  printf "."
done
clear
