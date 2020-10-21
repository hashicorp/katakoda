# =======================================================================
# Vault Telemetry Lab (vtl)
#
# =======================================================================

terraform {
  required_version = ">= 0.13"
}

# -----------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------

variable "docker_host" {
  default = "unix:///var/run/docker.sock"
}

variable "splunk_version" {
  default = "8.0.4.1"
}

variable "telegraf_version" {
  default = "1.12.6"
}

variable "vault_version" {
  default = "1.5.4"
}

variable "fluentd_splunk_hec_version" {
  default = "0.0.2"
}

# -----------------------------------------------------------------------
# Global configuration
# -----------------------------------------------------------------------

terraform {
  backend "local" {
    path = "/root/vtl/tfstate/terraform.tfstate"
  }
}

# -----------------------------------------------------------------------
# Provider configuration
# -----------------------------------------------------------------------

provider "docker" {
  host = var.docker_host
}

# -----------------------------------------------------------------------
# Custom network
# -----------------------------------------------------------------------
resource "docker_network" "vtl_network" {
  name       = "vtl-network"
  attachable = true
  ipam_config { subnet = "10.42.10.0/24" }
}

# -----------------------------------------------------------------------
# Splunk resources
# -----------------------------------------------------------------------

resource "docker_image" "splunk" {
  name         = "splunk/splunk:${var.splunk_version}"
  keep_locally = true
}

resource "docker_container" "splunk" {
  name  = "vtl-splunk"
  image = docker_image.splunk.latest
  env   = ["SPLUNK_START_ARGS=--accept-license", "SPLUNK_PASSWORD=vtl-password"]
  upload {
    content = (file("${path.cwd}/vtl/config/default.yml"))
    file    = "/tmp/defaults/default.yml"
  }
  ports {
    internal = "8000"
    external = "8000"
    protocol = "tcp"
  }
  networks_advanced {
    name         = "vtl-network"
    ipv4_address = "10.42.10.100"
  }
}

# -----------------------------------------------------------------------
# Fluentd resources
# Uses @brianshumate's fluentd-splunk-hec image
# https://github.com/brianshumate/fluentd-splunk-hec
# -----------------------------------------------------------------------

resource "docker_image" "fluentd_splunk_hec" {
  name         = "brianshumate/fluentd-splunk-hec:${var.fluentd_splunk_hec_version}"
  keep_locally = true
}

resource "docker_container" "fluentd" {
  name  = "vtl-fluentd"
  image = docker_image.fluentd_splunk_hec.latest
  volumes {
    host_path      = "${path.cwd}/vault-audit-log"
    container_path = "/vault/logs"
  }
  volumes {
    host_path      = "${path.cwd}/vtl/config/fluent.conf"
    container_path = "/fluentd/etc/fluent.conf"
  }
  networks_advanced {
    name         = "vtl-network"
    ipv4_address = "10.42.10.101"
  }
}

# -----------------------------------------------------------------------
# Telegraf resources
# -----------------------------------------------------------------------

data "template_file" "telegraf_configuration" {
  template = file(
    "${path.cwd}/vtl/config/telegraf.conf",
  )
}

resource "docker_image" "telegraf" {
  name         = "telegraf:${var.telegraf_version}"
  keep_locally = true
}

resource "docker_container" "telegraf" {
  name  = "vtl-telegraf"
  image = docker_image.telegraf.latest
  networks_advanced {
    name         = "vtl-network"
    ipv4_address = "10.42.10.102"
  }
  upload {
    content = data.template_file.telegraf_configuration.rendered
    file    = "/etc/telegraf/telegraf.conf"
  }
}

# -----------------------------------------------------------------------
# Vault data and resources
# -----------------------------------------------------------------------

data "template_file" "vault_configuration" {
  template = (file("${path.cwd}/vtl/config/vault.hcl"))
}

resource "docker_image" "vault" {
  name         = "vault:${var.vault_version}"
  keep_locally = true
}

resource "docker_container" "vault" {
  name     = "vtl-vault"
  image    = docker_image.vault.latest
  env      = ["SKIP_CHOWN", "VAULT_ADDR=http://127.0.0.1:8200"]
  command  = ["vault", "server", "-log-level=trace", "-config=/vault/config"]
  hostname = "vtl-vault"
  must_run = true
  capabilities {
    add = ["IPC_LOCK"]
  }
  healthcheck {
    test         = ["CMD", "vault", "status"]
    interval     = "10s"
    timeout      = "2s"
    start_period = "10s"
    retries      = 2
  }
  networks_advanced {
    name         = "vtl-network"
    ipv4_address = "10.42.10.103"
  }
  ports {
    internal = "8200"
    external = "8200"
    protocol = "tcp"
  }
  upload {
    content = data.template_file.vault_configuration.rendered
    file    = "/vault/config/main.hcl"
  }
  volumes {
    host_path      = "${path.cwd}/vault-audit-log"
    container_path = "/vault/logs"
  }
}
