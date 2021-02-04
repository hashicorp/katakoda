# Start the Vault server in the background
mkdir -p ~/log
nohup sh -c "vault server -dev -dev-root-token-id="root" -dev-listen-address=0.0.0.0:8200 >~/log/vault.log 2>&1" > ~/log/nohup.log &

sleep 5

ufw allow 8200/tcp

export VAULT_ADDR=http://0.0.0.0:8200

# Login as root and create a userauth endpoint for the scenario.

vault login root

vault policy write scenario-policy scenario-policy.hcl

vault auth enable userpass

vault write auth/userpass/users/scenario-user \
  password=scenario-password \
  policies=scenario-policy

rm /root/.vault-token