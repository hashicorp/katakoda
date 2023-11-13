# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Install kubectl v1.18.0
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin
