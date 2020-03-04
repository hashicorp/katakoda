# Install Terraform and init config
# Install unzip - Katacoda docker image doesn't have unzip
apt-get install unzip
cd ~
curl -O https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
unzip terraform_0.12.20_linux_amd64.zip -d /usr/local/bin/
export HOME=~/tutorial
cd $HOME

# Clone docker compose files
git clone https://github.com/hashicorp/getting-started-terraform-consul-provider .
cd consul-playground 

# Run Docker Compose up (daemon)
docker-compose up -d

# Go back to workspace directory
cd ..

clear

echo "Ready!"