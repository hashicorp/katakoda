#!/bin/sh

KUBECTL_RELEASE=v1.21.0
TERRAFORM_RELEASE=0.15.4

# Install kubectl and add to PATH
curl -LO https://dl.k8s.io/release/${KUBECTL_RELEASE}/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin

# Install Terraform
curl -O https://releases.hashicorp.com/terraform/$TERRAFORM_RELEASE/terraform_${TERRAFORM_RELEASE}_linux_amd64.zip
unzip terraform_${TERRAFORM_RELEASE}_linux_amd64.zip -d /usr/local/bin/

touch main.tf

clear
