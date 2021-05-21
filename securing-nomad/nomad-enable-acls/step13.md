Use the `nomad acl policy apply` command to upload your policy specifications.

ACLs policies and tokens can only be manipulated by a user presenting a
management token. Since you unset NOMAD_TOKEN earlier to test the anonymous
policy, you will need to repopulate it from your bootstrap token file.

Switch back to the bootstrap token.

```
export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' ~/bootstrap.token)
```{{execute}}


### Upload the Application Developer policy

```
nomad acl policy apply \
  -description "Application Developer policy" \
  app-dev app-dev_policy.hcl
```{{execute}}

**Example Output**

```
$ nomad acl policy apply \
  -description "Application Developer policy" \
  app-dev app-dev_policy.hcl
Successfully wrote "app-dev" ACL policy!
```

### Upload the Production Operations policy

```
nomad acl policy apply \
  -description "Production Operations policy" \
  prod-ops prod-ops_policy.hcl
```{{execute}}

**Example Output**

```
$ nomad acl policy apply \
  -description "Production Operations policy" \
  prod-ops prod-ops_policy.hcl
Successfully wrote "prod-ops" ACL policy!
```
