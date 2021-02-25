<br />
<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
<p><strong>NOTE: </strong>
**Root** or **sudo** users have the ability to generate **periodic tokens**.
</p></div>


Periodic tokens have a TTL (validity period), but no max TTL; therefore, they may live for an infinite duration of time so long as they are renewed within their TTL. This is useful for long-running services that cannot handle regenerating a token.

> **NOTE:** When you set `period`, it becomes the token renewal period (TTL). When a period and an explicit max TTL were both set on a token, it behaves as a periodic token. However, once the explicit max TTL is reached, the token will be revoked.


Create a token with 24 hours period and save it in a file named, `periodic-token.txt`.

```
vault token create -policy="default" -period=24h -format=json \
   | jq -r ".auth.client_token" > periodic-token.txt
```{{execute T1}}

Review the token details.

```
vault token lookup $(cat periodic-token.txt)
```{{execute T1}}

You can renew the generated token indefinitely for as long as it does not expire. If you do not renew, the token expires after 24 hours. You will learn how to renew a token later.

```
clear
```{{execute T1}}
