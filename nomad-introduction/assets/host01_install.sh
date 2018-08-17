#!/usr/bin/env sh

curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip
chmod +x /usr/bin/unzip

curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
unzip -d  /usr/bin/ ~/consul.zip
chmod +x /usr/bin/consul

curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.8.4/nomad_0.8.4_linux_amd64.zip
unzip -d  /usr/bin/ ~/nomad.zip
chmod +x  /usr/bin/nomad

rm ~/nomad.zip ~/consul.zip

mkdir -p ~/log

consul agent -dev -client=0.0.0.0 >~/log/consul.log 2>&1 &

nomad agent -dev -bind=0.0.0.0 >~/log/nomad.log 2>&1 &
nomad -autocomplete-install
