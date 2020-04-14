Vault is distributed as a [binary package](https://www.vaultproject.io/downloads.html) for all supported platforms and architectures.

Vault is distributed as a binary package for all supported platforms and architectures. To install Vault, find the appropriate package for your system and download it.

> Enter the following command into the terminal, or click on the command (`⮐`) to automatically copy it into the terminal and execute to downloads the Vault binary for Linux.

```
export VAULT=1.4.0
wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
```{{execute}}

After downloading Vault, unzip the package, and go ahead and remove the zip file:

```
unzip vault_${VAULT}_linux_amd64.zip && rm vault_${VAULT}_linux_amd64.zip
```{{execute}}

Vault runs as a single binary named vault. Any other files in the package can be safely removed and Vault will still function.

Make sure that the vault binary is available on the `PATH`:

```
install -c -m 0755 vault /usr/bin
```{{execute}}

## Verify the installation

By executing `vault`, you should see help output:

```
vault
```{{execute}}

## Command completion

Vault also includes command-line completion for subcommands, flags, and path arguments where supported. To install command-line completion, you must be using Bash, ZSH or Fish. Unfortunately other shells are not supported at this time.

To install completions, run:

```
vault -autocomplete-install
```{{execute}}

This will automatically install the helpers in your `~/.bashrc` or `~/.zshrc`, or to `~/.config/fish/completions/vault.fish` for Fish users. Then restart your terminal or reload your shell:

```
exec $SHELL
```{{execute}}

Now when you type vault `<tab>`, Vault will suggest options. This is very helpful for beginners and advanced Vault users.
