#!/usr/bin/env bash
# shellcheck disable=SC2016

export log_dir="/root/.log"

mkdir -p "$log_dir"

# ensure unzip and uuid-runtime are installed
apt update && \
apt install -y unzip uuid-runtime >> "$log_dir"/install.log

mkdir -p /root/vtl/{config,tfstate}
mkdir /root/vault-audit-log

# NOTE: Unable to get assets consistently working in docker environments
#       after numerous attempts, so going to just write the files out with
#       cat for now since that actually works.

cat > /root/main.tf << 'EOF'
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
  # default = "8.0.4.1"
  default = "8.1"
}

variable "telegraf_version" {
  default = "1.12.6"
}

variable "vault_version" {
  default = "1.6.0"
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
  name        = "vtl-network"
  attachable  = true
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

EOF

cat > /root/versions.tf << EOF
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}
EOF

cat > /root/vtl/config/fluent.conf << 'EOF'
<source>
@type tail
  path /vault/logs/vault-audit.log
  pos_file /vault/logs/vault-audit-log.pos
  <parse>
    @type json
    time_format %iso8601
  </parse>
  tag vault_audit
</source>

<filter vault_audit>
  @type record_transformer
  <record>
    cluster v5
  </record>
</filter>

<match vault_audit.**>
  @type splunk_hec
  host 10.42.10.100
  port 8088
  token 12b8a76f-3fa8-4d17-b67f-78d794f042fb
</match>
EOF

cat > /root/vtl/config/default.yml << 'EOF'
---
ansible_connection: local
ansible_environment: {}
ansible_post_tasks: null
ansible_pre_tasks: null
cert_prefix: https
config:
  baked: default.yml
  defaults_dir: /tmp/defaults
  env:
    headers: null
    var: SPLUNK_DEFAULTS_URL
    verify: true
  host:
    headers: null
    url: null
    verify: true
  max_delay: 60
  max_retries: 3
  max_timeout: 1200
dmc_asset_interval: 3,18,33,48 * * * *
dmc_forwarder_monitoring: false
docker: true
hide_password: false
java_download_url: null
java_update_version: null
java_version: null
retry_delay: 6
retry_num: 60
shc_sync_retry_num: 60
splunk:
  admin_user: admin
  allow_upgrade: true
  app_paths:
    default: /opt/splunk/etc/apps
    deployment: /opt/splunk/etc/deployment-apps
    httpinput: /opt/splunk/etc/apps/splunk_httpinput
    idxc: /opt/splunk/etc/master-apps
    shc: /opt/splunk/etc/shcluster/apps
  appserver:
    port: 8065
  asan: false
  auxiliary_cluster_masters: []
  build_url_bearer_token: null
  cluster_master_url: null
  connection_timeout: 0
  deployer_url: null
  dfs:
    dfc_num_slots: 4
    dfw_num_slots: 10
    dfw_num_slots_enabled: false
    enable: false
    port: 9000
    spark_master_host: 127.0.0.1
    spark_master_webui_port: 8080
  enable_service: false
  exec: /opt/splunk/bin/splunk
  group: splunk
  hec:
    ca: null
    cert: null
    enable: true
    password: null
    port: 8088
    ssl: false
    token: 5e14336d-3a44-4db1-860d-4c9fe67fbc32
  conf:
    - key: inputs
      value:
        directory: /opt/splunk/etc/apps/splunk_httpinput/local
        content:
          http:
            disabled: 0
            enableSSL: 0
    - key: authorize
      value:
        directory: /opt/splunk/etc/system/local/
        content:
          role_admin:
            grantableRoles: admin
            srchIndexesAllowed: '*;_*;vault-audit;vault-metrics'
            srchIndexesDefault: 'main;vault-audit;vault-metrics'
            srchMaxTime: 8640000
    - key: indexes
      value:
        directory: /opt/splunk/etc/apps/search/local/
        content:
          vault-metrics:
            coldPath: $SPLUNK_DB/vault-metrics/colddb
            datatype: metric
            enableDataIntegrityControl: 0
            enableTsidxReduction: 0
            homePath: $SPLUNK_DB/vault-metrics/db
            maxTotalDataSizeMB: 2048
            thawedPath: $SPLUNK_DB/vault-metrics/thaweddb
            archiver.enableDataArchive: 0
            bucketRebuildMemoryHint: 0
            compressRawdata: 1
            enableOnlineBucketRepair: 1
            metric.enableFloatingPointCompression: 1
            minHotIdleSecsBeforeForceRoll: 0
            suspendHotRollByDeleteQuery: 0
            syncMeta: 1
          vault-audit:
            coldPath: $SPLUNK_DB/vault-audit/colddb
            datatype: event
            enableDataIntegrityControl: 0
            enableTsidxReduction: 0
            homePath: $SPLUNK_DB/vault-audit/db
            maxTotalDataSizeMB: 2048
            thawedPath: $SPLUNK_DB/vault-audit/thaweddb
            archiver.enableDataArchive: 0
            bucketRebuildMemoryHint: 0
            compressRawdata: 1
            enableOnlineBucketRepair: 1
            metric.enableFloatingPointCompression: 1
            minHotIdleSecsBeforeForceRoll: 0
            suspendHotRollByDeleteQuery: 0
            syncMeta: 1
    - key: inputs
      value:
        directory: /opt/splunk/etc/apps/splunk_httpinput/local
        content:
          http://Vault Metrics:
            disabled: 0
            index: vault-metrics
            indexes: vault-metrics
            token: 42c0ff33-c00l-7374-87bd-690ac97efc50
            sourcetype: hashicorp_vault_telemetry
          http://Vault Audit:
            disabled: 0
            index: vault-audit
            indexes: vault-audit
            token: 12b8a76f-3fa8-4d17-b67f-78d794f042fb
            sourcetype: hashicorp_vault_audit_log
    - key: web
      value:
        directory: /opt/splunk/etc/system/local
        content:
          settings:
            verifyCookiesWorkDuringLogin: false
            enableSplunkWebSSL: true
            tools.sessions.secure: false
            tools.sessions.forceSecure: false
  home: /opt/splunk
  http_enableSSL: false
  http_enableSSL_cert: null
  http_enableSSL_privKey: null
  http_enableSSL_privKey_password: null
  http_port: 8000
  verify_cookies_work_during_login: false
  idxc:
    discoveryPass4SymmKey: P2sCPCanaj49BMRK5oC0dGXGd+YejlMD
    label: idxc_label
    pass4SymmKey: P2sCPCanaj49BMRK5oC0dGXGd+YejlMD
    replication_factor: 3
    replication_port: 9887
    search_factor: 3
    secret: P2sCPCanaj49BMRK5oC0dGXGd+YejlMD
  ignore_license: false
  kvstore:
    port: 8191
  launch: {}
  license_download_dest: /tmp/splunk.lic
  license_master_url: null
  multisite_master_port: 8089
  multisite_replication_factor_origin: 2
  multisite_replication_factor_total: 3
  multisite_search_factor_origin: 1
  multisite_search_factor_total: 3
  opt: /opt
  pass4SymmKey: null
  password: vtl-password
  pid: /opt/splunk/var/run/splunk/splunkd.pid
  root_endpoint: null
  s2s:
    ca: null
    cert: null
    enable: true
    password: null
    port: 9997
    ssl: false
  search_head_captain_url: null
  secret: null
  service_name: null
  set_search_peers: true
  shc:
    deployer_push_mode: null
    label: shc_label
    pass4SymmKey: LPZIns9px+aAyj7F8sjRbTp1tKCn1K5f
    replication_factor: 3
    replication_port: 9887
    secret: LPZIns9px+aAyj7F8sjRbTp1tKCn1K5f
  smartstore: null
  ssl:
    ca: null
    cert: null
    enable: true
    password: null
  svc_port: 8089
  tar_dir: splunk
  user: splunk
  wildcard_license: false
splunk_home_ownership_enforcement: true
splunkbase_password: null
splunkbase_token: null
splunkbase_username: null
wait_for_splunk_retry_num: 60

EOF

cat > /root/vtl/config/telegraf.conf << 'EOF'
# Telegraf Configuration

# Global tags relate to and are available for use in Splunk searches
# Of particular note are the index tag, which is required to match the
# configured metrics index name and the cluster tag which should match the
# value of Vault's cluster_name configuration option value.

[global_tags]
  index="vault-metrics"
  datacenter = "us-east-1"
  role       = "vault-server"
  cluster    = "vtl"

# Agent options around collection interval, sizes, jitter and so on
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  precision = ""
  hostname = ""
  omit_hostname = false

# An input plugin that listens on UDP/8125 for statsd compatible telemetry
# messages using Datadog extensions which are emitted by Vault
[[inputs.statsd]]
  protocol = "udp"
  service_address = ":8125"
  metric_separator = "."
  datadog_extensions = true

# An output plugin that can transmit metrics over HTTP to Splunk
# You must specify a valid Splunk HEC token as the Authorization value
[[outputs.http]]
  url = "http://10.42.10.100:8088/services/collector"
  data_format="splunkmetric"
  splunkmetric_hec_routing=true
  [outputs.http.headers]
    Content-Type = "application/json"
    Authorization = "Splunk 42c0ff33-c00l-7374-87bd-690ac97efc50"

# Read metrics about cpu usage using default configuration values
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  collect_cpu_time = false
  report_active = false
  fieldpass = ["usage_idle","usage_iowait","usage_irq","usage_nice","usage_softirq","usage_steal","usage_system","usage_user"]

# Read metrics about memory usage
[[inputs.mem]]
  # No configuration required

# Read metrics about network interface usage
[[inputs.net]]
  # Uses default configuration

# Read metrics about swap memory usage
[[inputs.swap]]
  # No configuration required

# Read metrics about disk usage using default configuration values
[[inputs.disk]]
  ## By default stats will be gathered for all mount points.
  ## Set mount_points will restrict the stats to only the specified mount points.
  ## mount_points = ["/"]
  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "overlay", "aufs", "squashfs"]

[[inputs.diskio]]
  # devices = ["sda", "sdb"]
  # skip_serial_number = false

[[inputs.kernel]]
  # No configuration required

[[inputs.linux_sysctl_fs]]
  # No configuration required

[[inputs.net]]
  # Specify an interface or all
  # interfaces = ["enp0s*"]

[[inputs.netstat]]
  # No configuration required

[[inputs.processes]]
  # No configuration required

[[inputs.procstat]]
 pattern = "(vault)"

[[inputs.system]]
  # No configuration required

EOF

cat > /root/vtl/config/vault.hcl << 'EOF'
cluster_name = "vtl"
log_level = "trace"
ui        = true

storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

telemetry {
  dogstatsd_addr                 = "10.42.10.102:8125"
  enable_hostname_label          = true
  disable_hostname               = true
  enable_high_cardinality_labels = "*"
}

EOF
