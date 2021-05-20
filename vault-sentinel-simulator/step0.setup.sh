# shellcheck disable=SC2148

# Start the Vault server in the background
# (If we will do a policy deployment lab)
# mkdir -p ~/log
# nohup sh -c "vault server -dev -dev-root-token-id=root # -dev-listen-address=0.0.0.0:8200 -log-level=trace >~/log/vault.log 2>&1" > ~/# log/nohup.log &
#
# sleep 5
#
# ufw allow 8200/tcp
#
# export VAULT_ADDR=http://0.0.0.0:8200
#
# vault login root
#
# # Used by personas in scenario
#
# vault auth enable userpass

# Download and install Sentinel Simulator binary at version 0.18.2
# (base image currently using version 0.15.5 as of this writing)

# curl -O https://releases.hashicorp.com/sentinel/# 0.18.2/sentinel_0.18.2_linux_amd64.zip
#
# unzip sentinel_0.18.2_linux_amd64.zip
#
# sudo install sentinel /usr/local/bin/sentinel
#
# rm -f sentinel

# Set up workshop-one files

mkdir -p workshop-one/test/cidr-check

cat > workshop-one/cidr-check.sentinel << EOF
import "sockaddr"
import "strings"

# Only evaluated for create, update, and delete operations against kv/ path
precond = rule {
    request.operation in ["create", "update", "delete"] and
    strings.has_prefix(request.path, "kv/")
}

# Requests must originate from our private IP range
cidrcheck = rule {
    sockaddr.is_contained(request.connection.remote_addr, "122.22.3.4/32")
}

# Check the precondition before executing the cidrcheck
main = rule when precond {
    cidrcheck
}
EOF

cat > workshop-one/test/cidr-check/success.json << EOF
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.4"
      },
      "operation": "create",
      "path": "secret/orders"
    }
  }
}
EOF

cat > workshop-one/test/cidr-check/fail.json << EOF
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.10"
      },
      "operation": "create",
      "path": "kv/orders"
    }
  },
  "test": {
    "precond": true,
    "main": false
  }
}
EOF
