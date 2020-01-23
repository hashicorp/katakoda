
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

install_zip "consul" "https://releases.hashicorp.com/consul/1.6.2/consul_1.6.2_linux_amd64.zip"

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.10.2/nomad_0.10.2_linux_amd64.zip"

install_zip "terraform" "https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip"

install_zip "vault" "https://releases.hashicorp.com/vault/1.3.2/vault_1.3.2_linux_amd64.zip"

install_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.24.0/consul-template_0.24.0_linux_amd64.zip"

install_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.2/envconsul_0.9.2_linux_amd64.zip"
