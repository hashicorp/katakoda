# Start the Vault server in the background
mkdir -p ~/log
nohup sh -c "vault server -dev -dev-root-token-id="root" -dev-listen-address=0.0.0.0:8200 >~/log/vault.log 2>&1" > ~/log/nohup.log &


sleep 5

ufw allow 8200/tcp

export VAULT_ADDR=http://0.0.0.0:8200

# Login as root and create a userauth endpoint for the operator of the scenario.

vault login root

vault policy write operator-policy operator-policy.hcl

vault auth enable userpass

vault write auth/userpass/users/operator \
  password=operator-password \
  policies=operator-policy

rm /root/.vault-token