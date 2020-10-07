#!/bin/sh

# Install kubectl and add to PATH
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin

# Install Terraform and init config
cd ~
curl -O https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
unzip terraform_0.13.3_linux_amd64.zip -d /usr/local/bin/

touch main.tf

clear 
