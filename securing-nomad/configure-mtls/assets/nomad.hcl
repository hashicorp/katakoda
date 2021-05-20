## This configuration enables someone to run a "single-node cluster" easily
## using the systemd unit.

data_dir  = "/opt/nomad/data"
log_level = "DEBUG"

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}
