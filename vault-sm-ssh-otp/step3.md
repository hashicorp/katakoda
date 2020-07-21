### Create the ubuntu user

```shell-session
useradd ubuntu -m
```{{execute HOST2}}

### Install and configure vault-ssh-helper

Download the `vault-ssh-helper`.

```shell-session
wget https://releases.hashicorp.com/vault-ssh-helper/0.1.6/vault-ssh-helper_0.1.6_linux_amd64.zip
```{{execute HOST2}}

Unzip the vault-ssh-helper in `/usr/local/bin`.

```shell-session
sudo unzip -q vault-ssh-helper_0.1.6_linux_amd64.zip -d /usr/local/bin
```{{execute HOST2}}

Set `vault-ssh-helper` to executable.

```shell-session
sudo chmod 0755 /usr/local/bin/vault-ssh-helper
```{{execute HOST2}}

Set the user and group of `vault-ssh-helper` to `root`.

```shell-session
sudo chown root:root /usr/local/bin/vault-ssh-helper
```{{execute HOST2}}

Create a directory to store the configuration file.

```shell-session
sudo mkdir /etc/vault-ssh-helper.d/
```{{execute HOST2}}

Create the configuration file `/etc/vault-ssh-helper.d/config.hcl`.

```shell-session
sudo tee /etc/vault-ssh-helper.d/config.hcl <<EOF
vault_addr = "http://[[HOST_IP]]:8200"
tls_skip_verify = true
ssh_mount_point = "ssh"
allowed_roles = "*"
EOF
```{{execute HOST2}}

- `vault_addr` is the network address of the Vault server configured to generate the OTP.
- `tls_skip_verify` enables or disables TLS verification.
- `ssh_mount_point` is the Vault server path where the SSH secrets engine is enabled.
- `allowed_roles` defines all `*` or a comma-separated list of allowed roles defined in the SSH secrets engines.

### Modify the PAM SSHD configuration

Disable `common-auth`.

```shell-session
sudo sed -i 's/@include common-auth/# @include common-auth/' /etc/pam.d/sshd
```{{execute HOST2}}

Add authentication verification through the `vault-ssh-helper`.

```shell-session
echo -e "\nauth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -dev -config=/etc/vault-ssh-helper.d/config.hcl
auth optional pam_unix.so not_set_pass use_first_pass nodelay" | sudo tee -a /etc/pam.d/sshd
```{{execute HOST2}}

### Modify the SSHD configuration

Enable `ChallengeResponseAuthentication`.

```
sudo sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
```{{execute HOST2}}

Restart the SSHD service.

```
sudo systemctl restart sshd
```{{execute HOST2}}