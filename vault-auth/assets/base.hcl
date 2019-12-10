path "secret/data/training*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/*" {
   capabilities = ["list"]
}
