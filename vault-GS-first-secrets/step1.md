Now that the dev server is up and running, let's get straight to it and read and write our first secret.

Login with root token.

```
vault login root
```{{execute T1}}

Let's start by writing a secret. This is done very simply with the `vault kv` command, as shown below:

```
vault kv put secret/hello foo=world
```{{execute T1}}

This writes the pair `foo=world` to the path `secret/hello`. For now, it is important that the path is prefixed with `secret/`, otherwise this example won't work. The `secret/` prefix is where arbitrary secrets can be read and written.

You can even write multiple pieces of data, if you want:

```
vault kv put secret/hello foo=world excited=yes
```{{execute T1}}

`vault kv put` is a very powerful command. In addition to writing data directly from the command-line, it can read values and key pairs from `STDIN` as well as files. For more information, see the
[command documentation](https://www.vaultproject.io/docs/commands/index.html).

> **Warning:** The documentation uses the `key=value` based entry throughout, but it is more secure to use files if possible. Sending data via the CLI is often logged in shell history. For real secrets,
please use files. See the link above about reading in from `STDIN` for more information.

## Getting a Secret

As you might expect, secrets can be gotten with `vault get`:

```
vault kv get secret/hello
```{{execute T1}}

As you can see, the values we wrote are given back to us. Vault gets the data from storage and decrypts it.

The output format is purposefully whitespace separated to make it easy to pipe into a tool like `awk`.

This contains some extra information. Many secrets engines create leases for secrets that allow time-limited access to other systems, and in those cases `lease_id` would contain a lease identifier and `lease_duration` would contain the length of time for which the lease is valid, in seconds.

To print only the value of a given field:

```
vault kv get -field=excited secret/hello
```{{execute T1}}

Optional JSON output is very useful for scripts. For example below we use the `jq` tool to extract the value of the `excited` secret:

```
vault kv get -format=json secret/hello | jq -r .data.data.excited
```{{execute T1}}

## Deleting a Secret

Now that we've learned how to read and write a secret, let's go ahead and delete it. We can do this with `vault delete`:

```
vault kv delete secret/hello
```{{execute T1}}
