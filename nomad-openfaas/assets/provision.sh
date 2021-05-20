#! /bin/bash

log() {
  echo $(date) - ${1} | tee -a /var/log/provision.log
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

install_apt_deps() {
  log "Installing OS dependencies"
  export DEBIAN_FRONTEND=noninteractive
  apt-get -y update >> /var/log/provision.log 2>&1
  apt-get -y install sudo unzip >> /var/log/provision.log 2>&1 
  unset DEBIAN_FRONTEND
}

install_go() {
  log "Fetching zip and installing go"
  curl -s -L -o go1.16.1.linux-amd64.tar.gz https://dl.google.com/go/go1.16.1.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.16.1.linux-amd64.tar.gz
  rm go1.16.1.linux-amd64.tar.gz
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

await_nomad() {
  echo "Waiting for Nomad to start... This may take a couple of moments"
  n=0
  until [ $n -ge 10 ]
  nomadStart="false"
  do
    response=`curl -sL -w "%{http_code}\\n" "http://host01:4646/v1/status/leader" --connect-timeout 3 --max-time 5`
    if [[ "${response}" == "200" ]]; then
      nomadStart="true"
      break
    fi

    n=$[$n+1]
    sleep 2
  done

  if [[ "${nomadStart}" == "false" ]]
  then
    echo "Timed out waiting for Nomad"
    exit 1
  fi

  echo "Nomad started."
}

create_nomad_service() {
  if [ ! -f "/etc/nomad.d/nomad.hcl" ]
  then
    cp /tmp/nomad.hcl /etc/nomad.d/nomad.hcl
  fi
  systemctl enable nomad
}

start_nomad() {
  systemctl start nomad
  await_nomad
}

maybe_preprovision() {
  if [ -x /usr/local/bin/provision_scenario_pre.sh ]
  then
    /usr/local/bin/provision_scenario_pre.sh
  fi
}

maybe_postprovision() {
  if [ -x /usr/local/bin/provision_scenario_post.sh ]
  then
    /usr/local/bin/provision_scenario_post.sh
  fi
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

# Main stuff

fix_journal
install_apt_deps
install_go

install_zip "consul" "https://releases.hashicorp.com/consul/1.9.1/consul_1.9.5_linux_amd64.zip"
install_zip "nomad" "https://releases.hashicorp.com/nomad/1.1.0/nomad_1.1.0_linux_amd64.zip"

mkdir -p /etc/nomad.d
mkdir -p /opt/nomad/data

maybe_preprovision

create_nomad_service
start_nomad

### scenario specific ###

echo -n "Configuring... "
export HOME=/home/scrapbook
# Download job files
curl -L -o ~/faas.hcl 

nomad job run ~/faas.hcl
echo "Nomad with OpenFaaS Ready"

### End scenario specific ###

maybe_postprovision
finish
