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
  check {
    id = "web-check"
    http = "http://localhost:9002/health"
    method = "GET"
    interval = "1s"
    timeout = "1s"
  }
}