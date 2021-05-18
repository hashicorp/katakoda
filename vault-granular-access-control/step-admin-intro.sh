export VAULT_ADDR=http://0.0.0.0:8200

vault login root

vault policy write admins-policy admins-policy.hcl

vault write auth/userpass/users/admins \
  password=admins-password \
  policies=admins-policy
