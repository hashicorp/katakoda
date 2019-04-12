Vault is distributed as a [binary package](https://www.vaultproject.io/downloads.html) for all supported platforms and architectures.

To install Vault, find the appropriate package for your system and download it. (NOTE: Vault is packaged as a zip archive.)  

> Enter the following command into the terminal, or click on the command (`⮐`) to automatically copy it into the terminal and execute to downloads the `1.1.1` of the Vault binary for Linux.

```
export VAULT=1.1.1
wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
```{{execute}}


After downloading Vault, unzip the package, and go ahead and remove the zip file:

```
unzip vault_${VAULT}_linux_amd64.zip && rm vault_${VAULT}_linux_amd64.zip
```{{execute}}

Vault runs as a single binary named vault. Any other files in the package can be safely removed and Vault will still function.

```
ls -al | grep vault
```{{execute}}

Finally, make sure that the vault binary is available on the `PATH`:

```
install -c -m 0755 vault /usr/bin
```{{execute}}

**That's it!**

Execute the following command to verify the vault version:

```
vault version
```{{execute}}
