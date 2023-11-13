# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

while [ ! -x /usr/local/bin/provision.sh ]; do sleep 1; done; /usr/local/bin/provision.sh
