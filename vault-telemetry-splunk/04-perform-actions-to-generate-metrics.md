> Click the command (`⮐`) to automatically copy it into the terminal and execute it.

This step will help guide you to generate new data in Vault and as a result, updated telemetry metrics in Splunk.

You will use the `vault` CLI for these steps.

## K/V version 2 secrets

The first kind of new data you will generate are a set of static [key/value version 2 secrets](https://www.vaultproject.io/api-docs/secret/kv/kv-v2) with an incremental count to produce telemetry metrics for later analysis.

These commands will produce excessive output, so the output is sent to a log file to keep the terminal uncluttered.

> **NOTE**: You should wait until the `$` prompt reappears after executing each command before executing the next command.

First, enable a K/V version 2 secrets engine at the default path `kv/`.

```shell
vault secrets enable -version=2 kv
```{{execute}}

Now, generate 10 secrets.

```shell
for i in {1..10}
  do
    printf "."
    vault kv put kv/$i-secret-10 id="$(uuidgen)" >> step4.log 2>&1
done
echo
```{{execute}}

Next, generate 25 secrets.

```shell
for i in {1..25}
  do
    printf "."
    vault kv put kv/$i-secret-25 id="$(uuidgen)" >> step4.log 2>&1
done
echo
```{{execute}}

Generate 50 secrets.

```shell
for i in {1..50}
  do
    printf "."
    vault kv put kv/$i-secret-50 id="$(uuidgen)" >> step4.log 2>&1
done
echo
```{{execute}}

Finally, update the first 10 secrets and change their values.

```shell
for i in {1..10}
  do
    printf "."
    vault kv put kv/$i-secret-10 id="$(uuidgen)" >> step4.log 2>&1
done
echo
```{{execute}}

## Tokens & Leases

Enable a [username and password](https://www.vaultproject.io/api-docs/auth/userpass) (userpass) auth method, and login with it to generate some example tokens and leases.

First, write a "sudo" policy that will be attached to tokens created later.

```shell
vault policy write sudo - << EOT
// Example policy: "sudo"
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
```{{execute}}

Then, enable the userpass auth method.

```shell
vault auth enable userpass
```{{execute}}

Next, add a learner user with the password **vtl-password**.

```shell
vault write auth/userpass/users/learner \
  password=vtl-password \
  token_ttl=120m \
  token_max_ttl=140m \
  token_policies=sudo
```{{execute}}

Now, login to Vault 10 times as the learner user.

```shell
for i in {1..10}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password >> step4.log 2>&1
done
echo
```{{execute}}

Login 25 times as the learner user.

```shell
for i in {1..25}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password >> step4.log 2>&1
done
echo
```{{execute}}


Login 50 times as the learner user.

```shell
for i in {1..50}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password >> step4.log 2>&1
done
echo
```{{execute}}

Now, for a change, use the token auth method directly to create 200 tokens with only the default policy attached and no default TTL values, which means they will inherit the system maximum of 32 days (768h).

```shell
for i in {1..200}
  do
    printf "."
    vault token create -policy=default >> step4.log 2>&1
done
echo
```{{execute}}

Click **Continue** to proceed to step 5, where you can observe the new metrics around the activities you just performed.
