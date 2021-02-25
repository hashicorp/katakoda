# Install Terraform and init config
# Install docker, unzip - Ubuntu doesn't have docker, pipe to null so future commands work
apt-get install -y docker-ce docker-ce-cli containerd.io unzip < "/dev/null"

# Install unzip - Katacoda docker image doesn't have unzip
# apt-get install unzip
cd ..
curl -O https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_0.14.6_linux_amd64.zip -d /usr/local/bin/

# Clone docker compose files
git clone https://github.com/hashicorp/getting-started-terraform-consul-provider
mv getting-started-terraform-consul-provider/* ~

cd ~/consul-playground 

# Run Docker Compose up (daemon)
docker-compose up -d

# Go back to workspace directory
cd ..

clear

echo "Ready!"
