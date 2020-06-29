> Click the command (`⮐`) to automatically copy it into the terminal and execute it.

This step will help guide you to generate new data in Vault and as a result, updated telemetry metrics in Splunk.

You will use the `vault` CLI for these steps, so run the following command to ensure that you are back in the **Terminal** tab.

```shell
echo "Welcome back to the terminal."
```{{execute T1}}

## K/V version 2 secrets

The first kind of new data you will generate are a set of static [key/value version 2 secrets](https://www.vaultproject.io/api-docs/secret/kv/kv-v2) with an incremental count to produce telemetry metrics for later analysis.

These commands will produce excessive output, so the output is sent to a log file to keep the terminal uncluttered.

> **NOTE**: You should wait until the `$` prompt reappears after executing each command before executing the next command.

First, enable a K/V version 2 secrets engine at the default path `kv/`.

```shell
vault secrets enable -version=2 kv
```{{execute T1}}

Now, generate 10 secrets.

```shell
for i in {1..10}
  do
    printf "."
    vault kv put kv/$i-secret-10 id="$(uuidgen)" >> 10-secrets.log 2>&1
done
echo
```{{execute T1}}

Next, generate 25 secrets.

```shell
for i in {1..25}
  do
    printf "."
    vault kv put kv/$i-secret-25 id="$(uuidgen)" >> 25-secrets.log 2>&1
done
echo
```{{execute T1}}

Generate 50 secrets.

```shell
for i in {1..50}
  do
    printf "."
    vault kv put kv/$i-secret-50 id="$(uuidgen)" >> 50-secrets.log 2>&1
done
echo
```{{execute T1}}

Finally, update the first 10 secrets and change their values.

```shell
for i in {1..10}
  do
    printf "."
    vault kv put kv/$i-secret-10 id="$(uuidgen)" >> 10-secrets.log 2>&1
done
echo
```{{execute T1}}

## Tokens & Leases

Enable a [username and password](https://www.vaultproject.io/api-docs/auth/userpass) (userpass) auth method, and login with it to generate tokens and leases.

First, enable the userpass auth method.

```shell
vault auth enable userpass
```{{execute T1}}

Next, add a learner user with the password **vtl-password**.

```shell
vault write auth/userpass/users/learner password=vtl-password
```{{execute T1}}

Now, login to Vault 10 times as the learner user.

```shell
for i in {1..10}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password > 10-userpass.log 2>&1
done
echo
```{{execute T1}}

Login 25 times as the learner user.

```shell
for i in {1..25}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password > 25-userpass.log 2>&1
done
echo
```{{execute T1}}


Login 50 times as the learner user.

```shell
for i in {1..50}
  do
    printf "."
    vault login \
      -method=userpass \
      username=learner \
      password=vtl-password > 50-userpass.log 2>&1
done
echo
```{{execute T1}}

Click **Continue** to proceed to step 5, where you can observe the new metrics around the activities you just performed.
