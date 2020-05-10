# Get credentials from the database secrets engine
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
