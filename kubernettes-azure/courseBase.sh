curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -L -o ~/terraform.zip https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_linux_amd64.zip
unzip -d ~/.bin ~/terraform.zip
chmod +x ~/.bin/terraform

curl -L -o ~/.bin/configz https://github.com/nicholasjackson/configz/releases/download/0.1/configz
chmod +x ~/.bin/configz

rm ~/terraform.zip
