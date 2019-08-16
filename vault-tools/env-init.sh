#!/usr/bin/env bash
curl -s -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -s -L -o ~/vault.zip https://releases.hashicorp.com/vault/1.2.2/vault_1.2.2_linux_amd64.zip &&
unzip -d ~/.bin ~/vault.zip && rm ~/vault.zip

curl -sLo ~/consul-template.zip https://releases.hashicorp.com/consul-template/0.21.0/consul-template_0.21.0_linux_amd64.zip &&
unzip -d ~/.bin ~/consul-template.zip && rm ~/consul-template.zip

curl -sLo ~/envconsul.zip https://releases.hashicorp.com/envconsul/0.9.0/envconsul_0.9.0_linux_amd64.zip &&
unzip -d ~/.bin ~/envconsul.zip && rm ~/envconsul.zip

export VAULT_ADDR='http://127.0.0.1:8200'

apt-get install -y jq

ssh root@host01 "curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip && chmod +x /usr/bin/unzip && curl -L -o ~/vault.zip https://releases.hashicorp.com/vault/1.2.2/vault_1.2.2_linux_amd64.zip && unzip -d  /usr/bin/ ~/vault.zip && rm ~/vault.zip && apt-get install -y jq &$ export VAULT_ADDR='http://127.0.0.1:8200' && curl -sLo ~/consul-template.zip https://releases.hashicorp.com/consul-template/0.21.0/consul-template_0.21.0_linux_amd64.zip && unzip -d ~/.bin ~/consul-template.zip && rm ~/consul-template.zip && curl -sLo ~/envconsul.zip https://releases.hashicorp.com/envconsul/0.9.0/envconsul_0.9.0_linux_amd64.zip && unzip -d ~/.bin ~/envconsul.zip && rm ~/envconsul.zip &"
