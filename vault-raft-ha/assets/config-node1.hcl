storage "file" {
    path = "/root/vault-storage-file"
}

listener "tcp" {
  address = "127.0.0.1:8210"
  cluster_address = "127.0.0.1:8211"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:8210"
cluster_addr = "http://127.0.0.1:8211"
