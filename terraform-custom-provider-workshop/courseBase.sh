# Install Terraform and init config

TERRAFORM_RELEASE=0.15.4

# Install Terraform
curl -O https://releases.hashicorp.com/terraform/$TERRAFORM_RELEASE/terraform_${TERRAFORM_RELEASE}_linux_amd64.zip
unzip terraform_${TERRAFORM_RELEASE}_linux_amd64.zip -d /usr/local/bin/

# Clone docker compose files
git clone -b hashiconf-2020 https://github.com/hashicorp/terraform-provider-hashicups
cd ~/terraform-provider-hashicups/docker_compose

# Prevent `yes` command from accidentally being run
alias yes=""

cd ~/terraform-provider-hashicups

clear

echo "Ready"
# Run Docker Compose up
# docker-compose up