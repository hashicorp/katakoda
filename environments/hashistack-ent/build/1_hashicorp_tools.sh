
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

install_zip "consul" "https://releases.hashicorp.com/consul/1.8.4+ent/consul_1.8.4+ent_linux_amd64.zip"

install_zip "nomad" "https://releases.hashicorp.com/nomad/0.12.8+ent/nomad_0.12.8+ent_linux_amd64.zip"

install_zip "terraform" "https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip"

install_zip "vault" "https://releases.hashicorp.com/vault/1.7.1+ent/vault_1.7.1+ent_linux_amd64.zip"

install_zip "consul-template" "https://releases.hashicorp.com/consul-template/0.24.1/consul-template_0.24.1_linux_amd64.zip"

install_zip "envconsul" "https://releases.hashicorp.com/envconsul/0.9.2/envconsul_0.9.2_linux_amd64.zip"

install_zip "sentinel" "https://releases.hashicorp.com/sentinel/0.15.2/sentinel_0.15.2_linux_amd64.zip"

install_zip "packer" "https://releases.hashicorp.com/packer/1.6.2/packer_1.6.2_linux_amd64.zip"
