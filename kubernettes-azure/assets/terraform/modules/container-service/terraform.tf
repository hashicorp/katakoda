# Configure the Microsoft Azure Provider
resource "azurerm_container_service" "default" {
  name                   = "${var.name}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  orchestration_platform = "Kubernetes"

  master_profile {
    count = 1
    dns_prefix = "quakeserver"
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${file("~/.ssh/server_rsa.pub")}"
    }
  }

  agent_pool_profile {
    name       = "default"
    count      = 1
    dns_prefix = "quakekubeagent"
    vm_size    = "Standard_A0"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  diagnostics_profile {
    enabled = false
  }

  tags {
    Environment = "dev"
  }
}
