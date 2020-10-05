ha_storage "raft" {
  path    = "/root/raft-node3/"
  node_id = "node3"
}

storage "file" {
    path = "/root/vault-storage-file"
}

listener "tcp" {
  address = "127.0.0.1:8230"
  cluster_address = "127.0.0.1:8231"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:8230"
cluster_addr = "http://127.0.0.1:8231"
