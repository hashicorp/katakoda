
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

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.10.1/nomad_0.10.1_linux_amd64.zip"

install_zip "terraform" "https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip"

install_zip "vault" "https://releases.hashicorp.com/vault/1.2.4/vault_1.2.4_linux_amd64.zip"

install_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.22.1/consul-template_0.22.1_linux_amd64.zip"

install_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.1/envconsul_0.9.1_linux_amd64.zip"
