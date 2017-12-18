ssh root@host01 "curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip && chmod +x /usr/bin/unzip && curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.0.0/consul_1.0.0_linux_amd64.zip && unzip -d  /usr/bin/ ~/consul.zip && chmod +x /usr/bin/consul && curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.7.0/nomad_0.7.0_linux_amd64.zip && unzip -d  /usr/bin/ ~/nomad.zip && chmod +x  /usr/bin/nomad && rm ~/nomad.zip ~/consul.zip"
ssh root@host01 "mkdir -p ~/log && nohup sh -c \"consul agent -dev -advertise=$(ip route get 1 | awk '{print $NF;exit}') >~/log/consul.log 2>&1 & nohup nomad agent -dev -network-interface=ens3 -bind=0.0.0.0 >~/log/nomad.log 2>&1 &\" &"

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

apt-get install -y tree

# Setup Docker registry
docker run -d -e VIRTUAL_HOST=registry.test.training.katacoda.com -v /opt/registry/data:/var/lib/registry --name registry registry:2

docker create -v /etc/nginx/certs --name nginx_certs busybox
docker cp /certs/registry.test.training.katacoda.com.crt nginx_certs:/etc/nginx/certs/
docker cp /certs/registry.test.training.katacoda.com.key nginx_certs:/etc/nginx/certs/

docker run -d -p 80:80 -p 443:443 --volumes-from nginx_certs -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx benhall/nginx-registry-proxy:1.9.6
