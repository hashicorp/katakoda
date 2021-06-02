service {
  name = "web"
  tags = ["v1"]
  port = 9002
  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "api"
            local_bind_port = 5000
          }
        ]
      }
    }
  }
}