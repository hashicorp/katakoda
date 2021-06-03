// ## Service Mesh Configuration
// connect {
//   enabled = true
//   ca_provider = "consul"
// }

## By default client agents should only expose port 8301 
## used for gossip protocol. Gossip protocol should be encrypted
## on production environments.
// addresses {
//   // grpc = "127.0.0.1"
//   // http = "0.0.0.0"
//   // http = "127.0.0.1"
//   // https = "127.0.0.1"
//   // dns = "127.0.0.1"
// }

## Client agents will also expose a port for each 

## If HTTPS is enabled also GRPC will require mTLS to work.
## This might create issues when configuring sidecar proxies
## for Consul service mesh. 
## It is not recommended in general to change the default ports
## used by Consul because it might break some of the assumptions
## the agents use during operations and will require additional
## configuration effort. The DNS port is the only port that will not 
## require further configuration and can be changed to be adapted
## to your network requirements. 
ports {
  grpc  = 8502
  http  = 8500
  https = -1
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

## TLS Encryption (requires cert files to be present on the client nodes)
## Requests incoming that are not RPC (so HTTP and DNS) are not required to 
## provide a client certificate to connect. 
## This permits to access the UI or the REST API without mTLS.
## WARN: Having the UI and REST API not using TLS to communicate.
verify_incoming        = false
verify_incoming_rpc    = true
## All requests made by the agent will provide a client certificate.
verify_outgoing        = true
## All requests made to a server need to present a certificate 
## with server.<dc>.<domain> as SAN
verify_server_hostname = true

## The configuration used in the sandbox is based on auto_encrypt
## This requires only the certificate for the TLS CA and then uses 
## the service mesh CA (Connect CA) to generate short lived certificates.
ca_file = "/assets/secrets/consul-agent-ca.pem"

auto_encrypt {
  tls = true
}

## To configure your TLS encryption manually you can pass
## a valid certificate-key pair signed with the same CA you are using
## for your ca_file option. This option is discouraged because it will
## require the manual rotation of certificates.
// cert_file = "/etc/consul.d/dc1-client-consul-0.pem"
// key_file  = "/etc/consul.d/dc1-client-consul-0-key.pem"


## ACL (for now embedded with standard master token)
acl {
  enabled        = true
  default_policy = "deny"
  enable_token_persistence = true
  // tokens {
  //   ## Should have only minimal permissions to stay in the DC ?
  //   agent  = "root"
  //   ## This can be the DNS token for the agents serving DNS requests
  //   ## But can also be omitted for other ones. ?
  //   default  = "root"
  // }
}

## Telemetry options, probably better moving it in a different configuration
## file if you expect to change this frequently
telemetry {
  prometheus_retention_time = "24h"
  disable_hostname= false
}