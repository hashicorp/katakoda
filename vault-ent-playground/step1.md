Vault is distributed as a [binary package](https://www.vaultproject.io/downloads.html) for all supported platforms and architectures.

To install Vault Enterprise, find the appropriate package for your system and download it.

> Enter the following command into the terminal, or click on the command (`⮐`) to automatically copy it into the terminal and execute to downloads the Vault Enterprise binary for Linux.

```
export VAULT=1.4.0-rc1+ent
wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
```{{execute}}


After downloading Vault Enterprise, unzip the package, and go ahead and remove the zip file:

```
unzip vault_${VAULT}_linux_amd64.zip && rm vault_${VAULT}_linux_amd64.zip
```{{execute}}

Vault Enterprise runs as a single binary named vault. Any other files in the package can be safely removed.

Finally, make sure that the `vault` binary is available on the `PATH`:

```
install -c -m 0755 vault /usr/bin
```{{execute}}

**That's it!**

Execute the following command to verify the vault version:

```
vault version
```{{execute}}
