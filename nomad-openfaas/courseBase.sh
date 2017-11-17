ssh root@host01 "curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip && chmod +x /usr/bin/unzip && curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.0.0/consul_1.0.0_linux_amd64.zip && unzip -d  /usr/bin/ ~/consul.zip && chmod +x /usr/bin/consul && curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.7.0/nomad_0.7.0_linux_amd64.zip && unzip -d  /usr/bin/ ~/nomad.zip && chmod +x  /usr/bin/nomad && rm ~/nomad.zip ~/consul.zip"
ssh root@host01 "mkdir -p ~/log && nohup sh -c \"consul agent -dev >~/log/consul.log 2>&1 & nohup nomad agent -dev -bind=0.0.0.0 >~/log/nomad.log 2>&1 &\" &"

curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.0.0/consul_1.0.0_linux_amd64.zip
unzip -d  ~/.bin/ ~/consul.zip
chmod +x ~/.bin/consul

curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.7.0/nomad_0.7.0_linux_amd64.zip
unzip -d  ~/.bin/ ~/nomad.zip
chmod +x  ~/.bin/nomad

curl -L -o ~/terraform.zip https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip
unzip -d ~/.bin ~/terraform.zip
chmod +x ~/.bin/terraform

curl -L -o ~/.bin/faas-cli https://github.com/openfaas/faas-cli/releases/download/0.5.0/faas-cli
chmod +x ~/.bin/faas-cli

rm ~/nomad.zip ~/consul.zip ~/terraform.zip


# Download job files
curl -L -o ~/faas.hcl https://raw.githubusercontent.com/hashicorp/faas-nomad/master/nomad_job_files/faas.hcl
curl -L -o ~/monitoring.hcl https://raw.githubusercontent.com/hashicorp/faas-nomad/master/nomad_job_files/monitoring.hcl
