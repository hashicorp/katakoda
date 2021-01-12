#! /bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

# Download and install a binary.
#
# Arguments:
#     - Name of binary ("consul")
#     - URL of zipfile ("https://example.com/consul.zip")
#
install_zip()
{
    NAME="$1"
    DOWNLOAD_URL="$2"
    log "Installing ${NAME} from ${DOWNLOAD_URL}"
    curl -L -o ~/$NAME.zip $DOWNLOAD_URL
    sudo unzip -d /usr/local/bin/ ~/$NAME.zip
    sudo chmod +x /usr/local/bin/$NAME
    rm ~/$NAME.zip
}

install_product()
{
    PRODUCT="$1"
    VERSION="$2"
    DOWNLOAD_URL="https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip"
    install_zip "$PRODUCT" "$DOWNLOAD_URL"
}

install_packages()
{
    log "Installing HashiCorp Packages"
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update
    sudo apt-get install -y nomad consul vault terraform packer
    sudo apt-get clean all
}


install_packages
install_product "consul-template" "0.25.1"
install_product "envconsul" "0.10.0"
install_product "sentinel" "0.15.6"

# the vault package sets the ipc_lock capability which
# requires that the container be run in privileged mode
# to even run the vault cli command.

