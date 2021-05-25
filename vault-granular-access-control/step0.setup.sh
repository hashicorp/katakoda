# Start the Postgres server

docker pull postgres:latest

docker run \
      --name postgres \
      --env POSTGRES_USER=root \
      --env POSTGRES_PASSWORD=rootpassword \
      --detach  \
      --publish 5432:5432 \
      postgres

sleep 5

docker exec -i postgres psql <<EOF
CREATE ROLE ro NOINHERIT;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "ro";
EOF

# Start the Vault server in the background
mkdir -p ~/log
nohup sh -c "vault server -dev -dev-root-token-id="root" -dev-listen-address=0.0.0.0:8200 -log-level=trace >~/log/vault.log 2>&1" > ~/log/nohup.log &

sleep 5

ufw allow 8200/tcp

export VAULT_ADDR=http://0.0.0.0:8200

vault login root

vault audit enable file file_path=/root/log/vault_audit.log -log_raw=true

# Used by personas in scenario

vault auth enable userpass

# Create KV-V2 secrets engine

vault secrets enable -path=external-apis kv-v2

vault kv put external-apis/socials/twitter api_key=MQfS4XAJXYE3SxTna6Yzrw api_secret_key=uXZ4VHykCrYKP64wSQ72SRM10WZwirnXq5rmyiLnVk
vault kv put external-apis/socials/instagram api_key=vQYPLeiRFpr3cKLa7HCowQ api_secret_key=2Z3RxDxkgZ4qE39s3NYgwzHdHuNRriCAPb4nq2q7va

# Create database secrets engine

vault secrets enable -path=database database

vault write database/config/postgresql \
    plugin_name=postgresql-database-plugin \
    connection_url="postgresql://{{username}}:{{password}}@localhost:5432/postgres?sslmode=disable" \
    allowed_roles=readonly \
    username="root" \
    password="rootpassword"

vault write database/roles/readonly \
    db_name=postgresql \
    creation_statements=@readonly.sql \
    default_ttl=1h \
    max_ttl=24h

# Create transit secrets engine

vault secrets enable -path=transit transit
vault write -f transit/keys/app-auth