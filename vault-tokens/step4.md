Although you can renew the expiring token with `renew` command, tokens have ***max TTL*** (the system default max TTL is 32 days).  Once the max TTL is reached, the token will be revoked.

In some cases, having a token be revoked would be problematic. For instance, a long-running service needs to maintain its SQL connection pool over a long period of time. In this scenario, a **periodic token** can be used. Periodic tokens have **period** but no max TTL. Therefore, periodic tokens may live for an infinite amount of time, so long as they are renewed within their TTL.

Get help on `auth/token` path:

```
vault path-help auth/token
```{{execute}}


> **Root** or **sudo** users have the permission to generate periodic tokens. Periodic tokens have a TTL, but no max TTL; therefore, they may live for an infinite duration of time so long as they are renewed within their TTL. This is useful for long-running services that cannot handle regenerating a token.

## Create a Token Role

The API endpoint to create a token role is `auth/token/roles`.  Execute the following command to create a token role named, `monitor`.  This role has `base` policy attached and token renewal period of 24 hours (86400 seconds).

```
clear
vault write auth/token/roles/monitor allowed_policies="base" period="24h"
```{{execute}}

Execute the following command to display the role details:

```
vault read auth/token/roles/monitor
```{{execute}}


Execute the following command to create a token for role, `monitor`, and save the generated token in a file named, `monitor_token.txt`.

```
vault token create -role="monitor" \
      -format=json | jq -r ".auth.client_token" > monitor_token.txt
```{{execute}}


Display the token details:

```
vault token lookup $(cat monitor_token.txt)
```{{execute}}

Notice that the **`role`** is set to **`monitor`**.

This token can be renewed infinite number of times for as long as it hasn't reached its 24-hour TTL.
