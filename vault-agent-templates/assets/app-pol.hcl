# Permits token creation
path "auth/token/create" {
  capabilities = ["update"]
}

# Permits token renew
path "auth/token/renew" {
  capabilities = ["update"]
}

# Read-only permission on secret/
path "secret/data/*" {
  capabilities = ["read"]
}
