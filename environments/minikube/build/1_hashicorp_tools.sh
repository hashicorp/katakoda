
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

install_zip "consul" "https://releases.hashicorp.com/consul/1.7.3/consul_1.7.3_linux_amd64.zip"

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.11.2/nomad_0.11.2_linux_amd64.zip"

install_zip "terraform" "https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip"

install_zip "vault" "https://releases.hashicorp.com/vault/1.5.0/vault_1.5.0_linux_amd64.zip"

install_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.25.0/consul-template_0.25.0_linux_amd64.zip"

install_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.3/envconsul_0.9.3_linux_amd64.zip"

install_zip "sentinel" "https://releases.hashicorp.com/sentinel/0.15.5/sentinel_0.15.5_linux_amd64.zip"

install_zip "packer" "https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_linux_amd64.zip"
