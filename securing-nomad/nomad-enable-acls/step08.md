At this point, it is good practice to verify that the anonymous policy is
performing as expected.

You can unset your NOMAD_TOKEN environment variable to send unauthenticated
requests to your cluster.

```shell
unset NOMAD_TOKEN
```{{execute}}

Verify that the token is unset.

```shell
echo ${NOMAD_TOKEN}
```{{execute}}

Check the status.

```
nomad status
```{{execute}}

**Example Output**

```screenshot
$ nomad status
No running jobs
```

Once you have provided your users with tokens, you can update this anonymous
policy (don't forget the description) to be more restrictive or delete it
completely to deny all requests from unauthenticated users.
