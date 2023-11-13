# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mkdir -p ~/log
nohup sh -c "vault server -dev -dev-root-token-id="root" -dev-listen-address=0.0.0.0:8200 >~/log/vault.log 2>&1" > ~/log/nohup.log &
