## Service Mesh Configuration
connect {
  enabled = true
  ca_provider = "consul"
}

addresses {
  grpc = "127.0.0.1"
  // http = "127.0.0.1"
  // http = "0.0.0.0"
  https = "0.0.0.0"
  dns = "127.0.0.1"
}


ports {
  grpc  = 8502
  http  = 8500
  https = 443
  dns   = 53
}

recursors = ["8.8.8.8"]

## Disable script checks
enable_script_checks = false

## Enable local script checks
## Uncomment in case you need script checks
## running on the node. Useful for custom health checks
// enable_local_script_checks = true

## Centralized configuration
enable_central_service_config = true

## Data Persistence
data_dir = "/tmp/consul"

## TLS Encryption (requires cert files to be present on the server nodes)
verify_incoming        = false
verify_incoming_rpc    = true
verify_outgoing        = true
verify_server_hostname = true

// ca_file   = "/assets/secrets/consul-agent-ca.pem"
// cert_file = "/assets/secrets/server-consul.pem"
// key_file  = "/assets/secrets/server-consul-key.pem"

auto_encrypt {
  allow_tls = true
}

## ACL (for now embedded with standard master token)
acl {
  enabled        = true
  default_policy = "deny"
  enable_token_persistence = true
  enable_token_replication = true
  // tokens {
  //   master = "root"
  //   agent  = "root"
  //   // default  = "root"
  // }
}

## TODO: Move to different file
## Telemetry Configuration
// telemetry {
//   prometheus_retention_time = "24h"
//   disable_hostname= false
// }
