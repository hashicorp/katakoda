#/bin/bash

sudo apt-get install -y curl unzip

curl -o /tmp/consul https://releases.hashicorp.com/consul/0.9.0/consul_0.9.0_linux_amd64.zip?_ga=2.81510997.350956691.1501074853-440320576.1499833383
unzip /tmp/consul
sudo mv /tmp/consul /usr/bin/
