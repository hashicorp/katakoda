```
               __
    ..=====.. |==|      _______________________
    ||     || |= |     < Twitter keys, please! >
 _  ||     || |^*| _    -----------------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access to API keys stored within Vault. These secrets
are maintained in a KV-V2 secrets engine enabled at the path `socials`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Get the secret.

```shell
vault kv get socials/twitter
```{{execute}}

## As the application

The policies defined for `apps` do not grant it the capability to perform this
operation.

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Fail to get the secret.

```shell
vault kv get socials/twitter
```{{execute}}

It is time to discover how to write a policy to meet this requirement.

## Discover the policy change required

Login with the `root` user.

```shell
vault login root
```{{execute}}

#### with the CLI flags

The `vault` CLI communicates direclty with Vault. It can optionally display
the the HTTP verb and path requested by a command.

Show the *curl* command for getting the secret

```shell
vault kv get -output-curl-string socials/twitter
```

curl -H "X-Vault-Request: true" -H "X-Vault-Token: $(vault print token)"
http://localhost:8200/v1/socials/data/twitter

The HTTP verb by default is `GET` which translates to the `read` capability.
The requested URL displays the path `/socials/data/twitter`.

#### with the audit logs

Show the last logged object.

```shell
cat log/vault_audit.log | jq -s ".[-1]"
```{{execute}}

Show the request of the last logged object.

```shell
cat log/vault_audit.log | jq -s ".[-1].request"
```{{execute}}

Show the request's path and the request's operation.

```shell
cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}

#### with the API Docs

Select the KV-V2 API tab to view the [KV-V2 API
documentation](https://www.vaultproject.io/api-docs/secret/kv/kv-v2).

The [read secret
version](https://www.vaultproject.io/api-docs/secret/kv/kv-v2#read-secret-version)
operation describes the capability and the path. The operation requires the
`GET` HTTP verb which translates to the `read` capability. The templatized path
`/secret/data/:path` becomes `/socials/data/twitter` when the path element
is provided by the secret.

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy`.
3. Test the policy with  the `apps` user.
