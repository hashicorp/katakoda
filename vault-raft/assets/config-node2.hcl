storage "raft" {
  path    = "/root/raft-node2/"
  node_id = "node2"
}

listener "tcp" {
  address = "127.0.0.1:2200"
  cluster_address = "127.0.0.1:2201"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:2200"
cluster_addr = "http://127.0.0.1:2201"
