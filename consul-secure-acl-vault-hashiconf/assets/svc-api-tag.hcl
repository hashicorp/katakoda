service {
  name = "api"
  id = "api-1"
  tags = ["v1", "cts"]
  port = 9003
  connect {
    sidecar_service {}
  }
  check {
    id = "api-check"
    http = "http://localhost:9003/health"
    method = "GET"
    interval = "1s"
    timeout = "1s"
  }
}