export VAULT_ADDR=http://0.0.0.0:8200

vault login root

vault policy write apps-policy apps-policy.hcl

vault write auth/userpass/users/apps \
  password=apps-password \
  policies=apps-policy