#!/usr/bin/env bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


printf "Completing Terraform installation"

while [ ! -x /usr/local/bin/terraform ]; do
  sleep 2
  printf "."
done
clear
