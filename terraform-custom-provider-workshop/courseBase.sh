# Install Terraform and init config

+# Installs Terraform 0.14
+curl -O https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
+unzip terraform_0.14.7_linux_amd64.zip -d /usr/local/bin/

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