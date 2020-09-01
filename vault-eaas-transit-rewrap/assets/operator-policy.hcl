# Manage the transit secrets engine
path "transit/keys/*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

# Enable the transit secrets engine
path "sys/mounts/transit" {
  capabilities = [ "create", "update" ]
}

# Write ACL policies
path "sys/policies/acl/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# Create tokens for verification & test
path "auth/token/create" {
  capabilities = [ "create", "update", "sudo" ]
}
