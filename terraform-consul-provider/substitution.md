## Localhost Substitution

NOTE: If you are using Katacoda, Katacoda uses a unique method to route its services.

As a result, you should substitute any references to localhost to the following:

| Learn Address   | Katacoda Address |
| --------------  | ---------------- |
| localhost:8500  | `[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com` |
| localhost:9001  | `[[HOST_SUBDOMAIN]]-9001-[[KATACODA_HOST]].environments.katacoda.com` |
| localhost:8080  | `[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com` |

Remember to substitute `ACL_TOKEN_HERE` with your master ACL token. Your `main.tf` file should be similar to:

<pre class="file" data-filename="main.tf" data-target="replace"># Configure the Consul provider
provider "consul" {
  address    = "[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com"
  datacenter = "dc1"
  token      = "ACL_TOKEN_HERE"
}

# Register external node - counting
resource "consul_node" "counting" {
  name    = "counting"
  address = "[[HOST_SUBDOMAIN]]-9001-[[KATACODA_HOST]].environments.katacoda.com"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

# Register external node - dashboard
resource "consul_node" "dashboard" {
  name    = "dashboard"
  address = "[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

# Register Counting Service
resource "consul_service" "counting" {
  name    = "counting-service"
  node    = consul_node.counting.name
  port    = 80
  tags    = ["counting"]

  check {
    check_id                          = "service:counting"
    name                              = "Counting health check"
    status                            = "passing"
    http                              = "[[HOST_SUBDOMAIN]]-9001-[[KATACODA_HOST]].environments.katacoda.com"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}

# Register Dashboard Service
resource "consul_service" "dashboard" {
  name    = "dashboard-service"
  node    = consul_node.dashboard.name
  port    = 80
  tags    = ["dashboard"]

  check {
    check_id                          = "service:dashboard"
    name                              = "Dashboard health check"
    status                            = "passing"
    http                              = "[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com"
    tls_skip_verify                   = false
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
  }
}

# List all services
data "consul_services" "dc1" {}

output "consul_services_dc1" {
    value = data.consul_services.dc1
}

# List counting service information
data "consul_service" "counting" {
  name = consul_service.counting.name
}

output "counting_ports" {
  value = data.consul_service.counting
}

# List Consul agent node address and ports
data "consul_service" "agents" {
  name = "consul"
}

output "consul_agents_address_ports" {
  value = {
    for service in data.consul_service.agents.service:
    service.node_id => join(":", [service.node_address, service.port])
  }
}

</pre>