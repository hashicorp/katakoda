# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

export NOMAD_ADDR="http://host01:4646"

mkdir -p ~/log
nohup sh -c "consul agent -dev >~/log/consul.log 2>&1" > ~/log/nohup.log &
nohup sh -c "nomad agent -dev -bind=0.0.0.0 >~/log/nomad.log 2>&1" > ~/log/nohup.log &

nomad -autocomplete-install

nomad job init -short
