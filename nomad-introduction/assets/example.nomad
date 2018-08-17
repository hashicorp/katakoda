# For full documentation and examples, see
#     https://www.nomadproject.io/docs/job-specification/job.html
job "example" {
  group "cache" {
    count = 1

    task "redis" {
      driver = "docker"
      config {
        image = "redis:3.2"

        port_map {
          db = 6379
        }
      }

      logs {
        max_files     = 5
        max_file_size = 15
      }
      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
          mbits = 10
          port  "db"  {}
        }
      }
      service {
        name = "global-redis-check"
        tags = ["global", "cache"]
        port = "db"

        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    ephemeral_disk {
      size = 100
    }
  }

  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "5s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }
}
