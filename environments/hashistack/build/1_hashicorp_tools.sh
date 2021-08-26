log() {
  echo $(date) - ${@}
}

# Download and install a binary.
#
# Arguments:
#     - Name of binary ("consul")
#     - URL of zipfile ("https://example.com/consul.zip")
#
# Usage:
#   install_from_zip "consul" "https://example.com/consul.zip"
install_from_zip()
{
    NAME="$1"
    DOWNLOAD_URL="$2"

    mkdir -p /tmp

    curl -L -o /tmp/$NAME.zip $DOWNLOAD_URL
    sudo unzip -d /usr/local/bin/ /tmp/$NAME.zip
    sudo chmod +x /usr/local/bin/$NAME
    rm /tmp/$NAME.zip
}

install_from_apt() {
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    set +v
    CLI_REPO=$(lsb_release -cs)
    sudo echo "deb [arch=amd64] https://apt.releases.hashicorp.com ${CLI_REPO} main" \
        > /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update
    sudo apt-get install -y terraform=1.0.5 vault=1.8.1 consul=1.10.1 nomad=1.1.4 packer=1.7.4 waypoint=0.5.1 boundary=0.5.1
}

install_consul_service_binaries() {
    # Used by some Consul tutorials
    curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -o /usr/local/bin/counting-service
    curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -o /usr/local/bin/dashboard-service
    chmod +x /usr/local/bin/*-service
}

# Create a user account, usually for a service that needs to run
# a binary as that user, such as consul.
#
# Usage:
#   create_user_account_for "consul"
create_user_account_for() {
    NAME="$1"

    useradd $NAME --create-home
    mkdir -p /etc/$NAME.d
    mkdir -p /home/$NAME/log
    chown -R $NAME /home/$NAME
}

install_from_apt

install_from_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.25.2/consul-template_0.25.2_linux_amd64.zip"
install_from_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.3/envconsul_0.9.3_linux_amd64.zip"
install_from_zip "sentinel" "https://releases.hashicorp.com/sentinel/0.18.1/sentinel_0.18.1_linux_amd64.zip"

install_consul_service_binaries
create_user_account_for "consul"

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
