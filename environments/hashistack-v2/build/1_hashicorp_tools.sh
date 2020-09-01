
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

# install_product "consul" "1.8.3"
# install_product "nomad" "0.12.3"
# install_product "packer" "1.6.2"
# install_product "terraform" "0.13.1"

install_product "consul-template" "0.25.1"
install_product "envconsul" "0.10.0"
install_product "sentinel" "0.15.6"


curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install nomad consul vault terraform packer
sudo apt-get clean all

# the vault package sets the ipc_lock capability which
# requires that the container be run in privileged mode
# to even run the vault cli command.
sudo setcap cap_ipc_lock=-ep /usr/bin/vault



#install_product "vault" "1.5.3"
#mv /usr/local/bin/vault /usr/local/vault
