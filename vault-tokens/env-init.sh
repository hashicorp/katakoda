#!/usr/bin/env bash
curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -L -o ~/vault.zip https://releases.hashicorp.com/vault/0.10.2/vault_0.10.2_linux_amd64.zip &&
unzip -d ~/.bin ~/vault.zip && rm ~/vault.zip

export VAULT_ADDR='http://127.0.0.1:8200'

apt-get install -y jq

ssh root@host01 "curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip && chmod +x /usr/bin/unzip && curl -L -o ~/vault.zip https://releases.hashicorp.com/vault/0.10.2/vault_0.10.2_linux_amd64.zip && unzip -d  /usr/bin/ ~/vault.zip && rm ~/vault.zip && apt-get install -y jq &$ export VAULT_ADDR='http://127.0.0.1:8200' &"
