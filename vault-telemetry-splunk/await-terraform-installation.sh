#!/usr/bin/env bash
# Copyright IBM Corp. 2017, 2023
# SPDX-License-Identifier: MPL-2.0


printf "Completing Terraform installation"

while [ ! -x /usr/local/bin/terraform ]; do
  sleep 2
  printf "."
done
clear
