If you attempt to run a command at this point without providing a token, you will
encounter an error; try it out.

```
nomad status
```{{execute}}

**Example Output**

```
$ nomad status
Error querying jobs: Unexpected response code: 403 (Permission denied)
```

You can provide a token for CLI commands using the -token flag or by setting the
NOMAD_TOKEN environment variable. For this scenario, you can also load the
management token out of your bootstrap file into the NOMAD_TOKEN environment
variable with this one-liner.

```
export NOMAD_TOKEN=$(awk '/Secret ID/ {print $4}' ~/bootstrap.token)
```{{execute}}

Running the `nomad status` command will now complete successfully.

```
nomad status
```{{execute}}

**Example Output**

```
$ nomad status
No running jobs
```

## Create the anonymous policy on the server

Create the Nomad ACL policy by running

```
nomad acl policy apply \
  -description "Anonymous policy (full-access)" \
  anonymous anonymous_policy.hcl
```{{execute}}

This will upload your policy file to the server and return information about
the generated policy.

**Example Output**

```
$ nomad acl policy apply \
  -description "Anonymous policy (full-access)" \
  anonymous anonymous_policy.hcl
Successfully wrote "anonymous" ACL policy!
```
