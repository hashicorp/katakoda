```
               __
    ..=====.. |==|     _______________
    ||     || |= |    < Twitter, plz! >
 _  ||     || |^*| _   ---------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access to API keys stored within Vault. These secrets
are maintained in a KV-V2 secrets engine enabled at the path `external-apis`.
The secret path within the engine is `socials/twitter`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

You can clear the terminal before resume: `clear`{{execute}}

Get the secret.

```shell
vault kv get external-apis/socials/twitter
```{{execute}}

## As the application

The policies defined for `apps` does not grant it the capability to perform this
operation.

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Fail to get the secret.

```shell
vault kv get external-apis/socials/twitter
```{{execute}}

It is time to discover how to write a policy to meet this requirement.

## Discover the policy change required

Login with the `root` user.

```shell
vault login root
```{{execute}}

#### 1️⃣ with the CLI flags

The `vault` CLI communicates directly with Vault. It can optionally output a
`curl` command equivalent of its operation. This command contains the HTTP verb
and path requested.

Show the *curl* command for getting the secret

```shell
vault kv get -output-curl-string external-apis/socials/twitter
```{{execute}}

The response displays the `curl` command.

```shell
curl -H "X-Vault-Request: true" -H "X-Vault-Token: $(vault print token)" http://localhost:8200/v1/external-apis/data/socials/twitter
```

The HTTP verb by default is `GET` which translates to the `read` capability. The
requested URL displays the path `/external-apis/data/socials/twitter`.

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy`.
3. Test the policy with the `apps` user.
