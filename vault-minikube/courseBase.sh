# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

# Install Helm 3 and overwrite Helm 2
curl -LO https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -xvf helm-v3.2.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/
