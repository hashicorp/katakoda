# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

apt-get install -y jq

ssh -o StrictHostKeyChecking=no "root@host01"

ssh root@host01 "apt-get install -y jq  &"
