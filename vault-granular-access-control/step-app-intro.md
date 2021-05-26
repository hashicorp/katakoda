```
               __
    ..=====.. |==|     _______________
    ||     || |= |    < Hello, Vault! >
 _  ||     || |^*| _   ---------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application, or app, is a non-human client that requires API keys, database
credentials, and encryption-as-a-service. An app typically authenticates through
an *approle*. To make exploration easier *userpass* is enabled and the user name
`apps` was created.

Show the `apps` user.

```shell
vault read auth/userpass/users/apps
```{{execute}}

The `apps` user is assigned the `apps-policy` policy.

Show the `apps-policy` policy.

```shell
vault policy read apps-policy
```{{execute}}

The policy contains comments about future application requirements.

As the Vault server only maintains the latest version of the policy. A local
copy of the policy is maintained on this workstation.

Open the `apps-policy.hcl`{{open}} file in the editor.

This file matches the contents defined on the Vault server.

You are ready to implement the application's requirements.
