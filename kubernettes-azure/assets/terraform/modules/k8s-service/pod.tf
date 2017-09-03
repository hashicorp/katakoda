resource "kubernetes_pod" "quake" {
  metadata {
    name = "quake-client"

    labels {
      App = "quakeclient"
    }
  }

  spec {
    container {
      image = "quay.io/nicholasjackson/quake-client:latest"
      name  = "quakeclient"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "quake" {
  metadata {
    name = "quake-client"
  }

  spec {
    selector {
      App = "${kubernetes_pod.quake.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
