storage "raft" {
  path    = "/root/raft-node4/"
  node_id = "node4"

  retry_join {
    leader_api_addr = "http://127.0.0.1:8200"
  }

  retry_join {
    leader_api_addr = "http://127.0.0.1:2200"
  }

  retry_join {
    leader_api_addr = "http://127.0.0.1:3200"
  }
}

listener "tcp" {
  address = "127.0.0.1:4200"
  cluster_address = "127.0.0.1:4201"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:4200"
cluster_addr = "http://127.0.0.1:4201"
