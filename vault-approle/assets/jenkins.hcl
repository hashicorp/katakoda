# Read-only permission on 'secret/data/myapp/*' path
path "secret/data/myapp/*" {
  capabilities = [ "read" ]
}
