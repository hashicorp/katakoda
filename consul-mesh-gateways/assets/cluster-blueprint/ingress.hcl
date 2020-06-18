ingress "dashboard_dc1" {
    target = "k8s_cluster.dc1"
    service = "svc/kubernetes-dashboard"
    namespace = "kubernetes-dashboard"

    network  {
      name = "network.local"
    }

    port {
        remote = 8443
        local = 8443
        host = 18443
    }
}

ingress "dashboard_dc2" {
    target = "k8s_cluster.dc2"
    service = "svc/kubernetes-dashboard"
    namespace = "kubernetes-dashboard"

    network  {
      name = "network.local"
    }

    port {
        remote = 8443
        local = 8443
        host = 19443
    }
}

ingress "consul_dc1" {
    target = "k8s_cluster.dc1"
    service = "svc/consul-server"

    network  {
      name = "network.local"
    }

    port {
        remote = 8501
        local = 8501
        host = 8501
    }
}

ingress "consul_dc2" {
    target = "k8s_cluster.dc2"
    service = "svc/consul-server"

    network  {
      name = "network.local"
    }

    port {
        remote = 8501
        local = 8501
        host = 8502
    }
}

ingress "web_frontend" {
    target = "k8s_cluster.dc2"
    service = "svc/web"

    network  {
      name = "network.local"
    }

    port {
        remote = 9090
        local = 9090
        host = 9090
    }
}