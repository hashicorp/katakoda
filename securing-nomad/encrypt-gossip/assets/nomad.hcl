data_dir  = "/opt/nomad/data"
log_level = "DEBUG"

client {
  enabled = true
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

server {
  enabled          = true
  bootstrap_expect = 1
}