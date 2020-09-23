data_dir = "/opt/consul/data",
log_level = "INFO",
node_name = "server1",
server = true,
ui = true,
client_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP \"ens3\" }}"
bootstrap_expect = 1