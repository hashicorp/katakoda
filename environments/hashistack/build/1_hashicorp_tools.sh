
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

install_zip "consul" "https://releases.hashicorp.com/consul/1.6.1/consul_1.6.1_linux_amd64.zip"

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.10.0/nomad_0.10.0_linux_amd64.zip"

install_zip "terraform" "https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip"

install_zip "vault" "https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip"
