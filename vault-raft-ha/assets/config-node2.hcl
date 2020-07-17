ha_storage "raft" {
  path    = "/home/scrapbook/tutorial/raft-node2/"
  node_id = "node2"
}

storage "file" {
    path = "/home/scrapbook/tutorial/vault-storage-file"
}

listener "tcp" {
  address = "127.0.0.1:8220"
  cluster_address = "127.0.0.1:8221"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:8220"
cluster_addr = "http://127.0.0.1:8221"
