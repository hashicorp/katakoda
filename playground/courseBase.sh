curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.6.1/consul_1.6.1_linux_amd64.zip
unzip -d  ~/.bin/ ~/consul.zip 
chmod +x ~/.bin/consul

curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.9.5/nomad_0.9.5_linux_amd64.zip
unzip -d  ~/.bin/ ~/nomad.zip
chmod +x  ~/.bin/nomad 

curl -L -o ~/terraform.zip https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip
unzip -d ~/.bin ~/terraform.zip
chmod +x ~/.bin/terraform

rm ~/nomad.zip ~/consul.zip ~/terraform.zip

ssh root@host01 "curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip && chmod +x /usr/bin/unzip && curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.6.1/consul_1.6.1_linux_amd64.zip && unzip -d  /usr/bin/ ~/consul.zip && chmod +x /usr/bin/consul && curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.9.5/nomad_0.9.5_linux_amd64.zip && unzip -d  /usr/bin/ ~/nomad.zip && chmod +x  /usr/bin/nomad && rm ~/nomad.zip ~/consul.zip"
ssh root@host01 "mkdir -p ~/log && nohup sh -c \"consul agent -dev >~/log/consul.log 2>&1 & nohup nomad agent -dev -bind=0.0.0.0 >~/log/nomad.log 2>&1 &\" &"
