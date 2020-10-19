service = {
  name = "client"
  connect = {
    sidecar_service = {
      proxy = {
        upstreams = [
          {
            destination_name = "backend"
            local_bind_port = 9192
          }
        ]
      }
    }
  }
}