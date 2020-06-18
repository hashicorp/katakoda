cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${1}
}

fix_journal() {
  log "Fixing Journal"
  if [ ! -f "/etc/machine-id" ]
  then
    systemd-machine-id-setup > /dev/null 2>&1
    systemd-tmpfiles --create --prefix /var/log/journal
    systemctl start systemd-journald.service
  fi
}

install_zip() {
  NAME="$1"
  log "Fetching zip and installing ${NAME}"
  if [ ! -f "/usr/local/bin/$NAME" ]
  then
    DOWNLOAD_URL="$2"
    curl -s -L -o /tmp/$NAME.zip $DOWNLOAD_URL
    sudo unzip -qq -d /usr/local/bin/ /tmp/$NAME.zip
    sudo chmod +x /usr/local/bin/$NAME
    rm /tmp/$NAME.zip
  fi
}

create_nomad_service() {
  log "Creating Nomad Service"
  if [ ! -f /etc/nomad.d/config.hcl ]
  then
    cat > /etc/nomad.d/config.hcl <<EOF
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
EOF

  fi

  if [ ! -f /etc/systemd/system/nomad.service ]
  then
    cat > /etc/systemd/system/nomad.service <<-EOF
  [Unit]
  Description=Nomad
  Documentation=https://nomadproject.io/docs/
  Wants=network-online.target
  After=network-online.target
  StartLimitBurst=3
  StartLimitIntervalSec=10

  # When using Nomad with Consul it is not necessary to start Consul first. These
  # lines start Consul before Nomad as an optimization to avoid Nomad logging
  # that Consul is unavailable at startup.
  Wants=consul.service
  After=consul.service

  [Service]
  ExecReload=/bin/kill -HUP $MAINPID
  ExecStart=/usr/local/bin/nomad agent -config /etc/nomad.d
  KillMode=process
  KillSignal=SIGINT
  LimitNOFILE=65536
  LimitNPROC=infinity
  Restart=on-failure
  RestartSec=2
  TasksMax=infinity
  OOMScoreAdjust=-1000

  [Install]
  WantedBy=multi-user.target
EOF

  fi

  systemctl daemon-reload
  systemctl enable nomad --quiet
  systemctl start nomad
  ln -s /etc/nomad.d/config.hcl ~/nomad_config.hcl
}

create_consul_service() {
  log "Creating Consul Service"
  if [ ! -f /etc/consul.d/config.hcl ]
  then
    cat > /etc/consul.d/config.hcl <<EOF
bind_addr        = "{{GetInterfaceIP \"ens3\"}}"
bootstrap_expect = 1
client_addr      = "0.0.0.0"
data_dir         = "/opt/consul/data"
datacenter       = "dc1"
log_level        = "DEBUG"
server           = true
ui               = true

connect {
  enabled = true
}

ports {
  grpc = 8502
}
EOF

  fi

  if [ ! -f /etc/systemd/system/consul.service ]
  then
    cat > /etc/systemd/system/consul.service <<EOF
[Unit]
Description=Consul
Documentation=https://consul.io/docs/
Wants=network-online.target
After=network-online.target
StartLimitBurst=3
StartLimitIntervalSec=10

[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/consul agent -dns-port 53 -config-dir /etc/consul.d
KillMode=process
KillSignal=SIGINT
LimitNOFILE=65536
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
TasksMax=infinity

[Install]
WantedBy=multi-user.target
EOF

  fi

  systemctl daemon-reload
  systemctl enable consul --quiet
  systemctl start consul
  ln -s /etc/consul.d/config.hcl ~/consul_config.hcl
}

install_pyhcl() {
  log "Installing pyhcl"
  pip install -qqq pyhcl
}

install_cni() {
  log "Installing CNI Plugins..."
  curl -s -L -o cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v0.8.4/cni-plugins-linux-amd64-v0.8.4.tgz
  sudo mkdir -p /opt/cni/bin
  sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz
  rm cni-plugins.tgz
}

configure_nomad_tls() {
  mkdir -p /opt/nomad/ca
  cd /opt/nomad/ca
  consul tls ca create -domain=nomad > /dev/null
  consul tls cert create -domain=nomad -dc=global -server > /dev/null
  consul tls cert create -domain=nomad -dc=global -client > /dev/null
  mkdir -p /etc/nomad.d/tls
  cp nomad-agent-ca.pem /etc/nomad.d/tls
  cp global-server-nomad-0* /etc/nomad.d/tls
#   cat > /etc/nomad.d/tls.hcl <<EOF
# tls {
#   http = true
#   rpc  = true

#   ca_file   = "/etc/nomad.d/tls/nomad-agent-ca.pem"
#   cert_file = "/etc/nomad.d/tls/global-server-nomad-0.pem"
#   key_file  = "/etc/nomad.d/tls/global-server-nomad-0-key.pem"

#   verify_server_hostname = true
#   verify_https_client    = true
# }
# EOF

  cat > ~/tls_environment <<EOF
export NOMAD_CAPATH="/etc/nomad.d/tls/nomad-agent-ca.pem"
export NOMAD_CLIENT_CERT="/etc/nomad.d/tls/global-server-nomad-0.pem"
export NOMAD_CLIENT_KEY="/etc/nomad.d/tls/global-server-nomad-0-key.pem"
export NOMAD_ADDR="https://127.0.0.1:4646"
EOF

  systemctl restart nomad
  . ~/tls_environment
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

# Main stuff

fix_journal
install_pyhcl

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.11.2/nomad_0.11.2_linux_amd64.zip"
install_zip "consul" "https://releases.hashicorp.com/consul/1.7.3/consul_1.7.3_linux_amd64.zip"

mkdir -p /etc/nomad.d /etc/consul.d
mkdir -p /opt/nomad/data /opt/consul/data

create_nomad_service
create_consul_service

configure_nomad_tls

finish

EOFSRSLY

chmod +x /tmp/provision.sh
