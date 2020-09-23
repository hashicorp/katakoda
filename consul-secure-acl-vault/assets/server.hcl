# Base configuration
data_dir = "/opt/consul/data",
log_level = "INFO",
node_name = "server-1",
server = true,
ui = true,
client_addr = "0.0.0.0",
advertise_addr = "{{ GetInterfaceIP \"ens3\" }}",
bootstrap_expect = 1,

# ACL configuration
acl = {
    enabled = true
    default_policy = "deny"
    enable_token_persistence = true
}