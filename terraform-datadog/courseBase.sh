#!/bin/sh
minikube start

# Check helm and minikube completion
source <(helm completion bash)
source <(minikube completion bash)

# Installs Terraform 0.14
curl -O https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
unzip terraform_0.14.7_linux_amd64.zip -d /usr/local/bin/

rm terraform_0.14.7_linux_amd64.zip

# helm init
helm init

# add `datadog` Helm Charts (this provides `datadog/datadog:2.4.5`)
helm repo add "datadog" "https://helm.datadoghq.com/"

# update Helm Charts
helm repo update

# create user workspace
mkdir -p /root/
mkdir -p /tmp/repo

git clone https://github.com/hashicorp/learn-terraform-datadog.git /tmp/repo

cp /tmp/repo/variables.tf /root/
cp /tmp/repo/terraform.tf /root/
cp /tmp/repo/kubernetes.tf /root/
cp /tmp/repo/helm_datadog.tf /root/
cp /tmp/repo/datadog_dashboard.tf /root/
cp /tmp/repo/datadog_metrics.tf /root/
cp /tmp/repo/datadog_synthetics.tf /root/

cd /root/

clear

echo "Ready!"
