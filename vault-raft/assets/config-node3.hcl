storage "raft" {
  path    = "/home/scrapbook/tutorial/raft-node3/"
  node_id = "node3"
}

listener "tcp" {
  address = "127.0.0.1:3200"
  cluster_address = "127.0.0.1:3201"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:3200"
cluster_addr = "http://127.0.0.1:3201"
