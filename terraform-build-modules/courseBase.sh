# Install Terraform and init config

# Installs Terraform 0.14.6
curl -O https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_0.14.6_linux_amd64.zip -d /usr/local/bin/

# Clone GitHub repo
git clone -b localstack https://github.com/hashicorp/learn-terraform-modules
cd ~/learn-terraform-modules

# Run Docker Compose up (daemon)
# docker-compose up -d

# Install localstack (don't run dockerfile on katacoda)
pip3 install localstack awscli
localstack start &>localstack-output.log &

# Prevent `yes` command from accidentally being run
alias yes=""

# Adds mock AWS Credentials to environment variables
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

# Include current dir in prompt
PS1='\W$ '

# Download assets for S3 bucket
mkdir assets
curl -o assets/index.html https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/index.html
curl -o assets/error.html https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/error.html

clear

echo "Ready!"
