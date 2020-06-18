k8s_cluster "dc1" {
  driver  = "k3s" // default
  version = "v1.0.1"

  nodes = 1 // default

  network {
    name = "network.local"
    ip_address = "10.5.1.200"
  }
}

k8s_cluster "dc2" {
  driver  = "k3s" // default
  version = "v1.0.1"

  nodes = 1 // default

  network {
    name = "network.local"
    ip_address = "10.5.2.200"
  }
}

k8s_config "dashboard_dc1" {
    cluster = "k8s_cluster.dc1"

    paths = [
        "./k8s-dashboard.yml"
    ]
  
    wait_until_ready = true
}


k8s_config "dashboard_dc2" {
    cluster = "k8s_cluster.dc2"

    paths = [
        "./k8s-dashboard.yml"
    ]
  
    wait_until_ready = true
}
