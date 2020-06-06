
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

# Find the newest version of a tool and install it locally.
#
# WARNING: Does not work for all tools (vault)
#
# Usage:
#   install_latest_from_zip "consul"
install_latest_from_zip() {
    TOOL_NAME="$1"
    log Installing ${TOOL_NAME}

    # Retrieves lates version from checkpoint
    # Substitute this with APP_VERSION=x.y.z to configure a specific version.
    APP_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/${TOOL_NAME} | jq .current_version | tr -d '"')
    log Installing ${TOOL_NAME} ${APP_VERSION}
    curl -s https://releases.hashicorp.com/${TOOL_NAME}/${APP_VERSION}/${TOOL_NAME}_${APP_VERSION}_linux_amd64.zip -o ${TOOL_NAME}_${APP_VERSION}_linux_amd64.zip
    unzip ${TOOL_NAME}_${APP_VERSION}_linux_amd64.zip > /dev/null
    chmod +x ${TOOL_NAME}
    mv ${TOOL_NAME} /usr/local/bin/${TOOL_NAME}
    rm -rf ${TOOL_NAME}_${APP_VERSION}_linux_amd64.zip > /dev/null
}

install_helm() {
    # Install Helm 3 and overwrite Helm 2
    curl -LO https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
    tar -xvf helm-v3.2.1-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/bin/
}
install_helm

install_consul_service_binaries() {
    # Used by some Consul tutorials
    curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -o /usr/local/bin/counting-service
    curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -o /usr/local/bin/dashboard-service
    chmod +x /usr/local/bin/*-service
}
install_consul_service_binaries

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

install_latest_from_zip "consul"
install_latest_from_zip "nomad"
install_latest_from_zip "terraform"
install_latest_from_zip "packer"

create_user_account_for "consul"

install_from_zip "vault" "https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip"
install_from_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.25.0/consul-template_0.25.0_linux_amd64.zip"
install_from_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.3/envconsul_0.9.3_linux_amd64.zip"
install_from_zip "sentinel" "https://releases.hashicorp.com/sentinel/0.15.5/sentinel_0.15.5_linux_amd64.zip"
