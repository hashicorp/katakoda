This tutorial demonstrate the Vault installation on Ubuntu. For other operating systems, refer to [Install Vault](https://learn.hashicorp.com/vault/getting-started/install).

> Enter the following command into the terminal, or click on the command (`⮐`) to automatically copy it into the terminal and execute to downloads the Vault binary for Linux.


First, add the HashiCorp GPG key.

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```{{execute}}


Add the official HashiCorp Linux repository.

```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```{{execute}}

Finally, update and install Vault.

```
sudo apt-get update && sudo apt-get install vault
```{{execute}}

**That's it!**

Execute the following command to verify the vault version.

```
vault version
```{{execute}}
