# Install Terraform and init config

# Installs Terraform 0.14
curl -O https://releases.hashicorp.com/terraform/0.14.2/terraform_0.14.2_linux_amd64.zip
unzip terraform_0.14.2_linux_amd64.zip -d /usr/local/bin/

# Clone docker compose files
git clone -b katacoda https://github.com/hashicorp/learn-terraform-hashicups-provider
cd ~/learn-terraform-hashicups-provider/docker_compose

# Install HashiCups provider 
mkdir -p ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/linux_amd64
curl -LO https://github.com/hashicorp/terraform-provider-hashicups/releases/download/v0.3.1/terraform-provider-hashicups_0.3.1_linux_amd64.zip
unzip terraform-provider-hashicups_0.3.1_linux_amd64.zip -d ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/linux_amd64
chmod +x ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/linux_amd64/terraform-provider-hashicups_v0.3.1

# Prevent `yes` command from accidentally being run
alias yes=""

# Run Docker Compose up
docker-compose up
