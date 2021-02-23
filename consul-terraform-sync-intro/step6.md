Note that the `terraform.tfvars` content and the task did not 
match the `api` service. This was expected from the configuration since it 
defined a service block matching instances of the `api` services but only if
with a specific tag, `cts`.

### Change service definition

To make the service intercepted by Consul-Terraform-Sync, you can update the 
service definition to include the `cts` tag.

The lab provides a configuration file `assets/svc-api-tag.hcl`{{open}} that 
contains the updates.

`docker exec \
  --env CONSUL_HTTP_ADDR='127.0.0.1:8500' \
  --env CONSUL_HTTP_TOKEN="${CONSUL_HTTP_TOKEN}" \
  api sh -c "consul services register assets/svc-api-tag.hcl"`{{execute T1}}

If successful the command should output the following.

```snapshot
Registered service: api
```

You can now confirm the service is assigned the new tag with the 
`consul catalog` command.

`consul catalog services -tags`{{execute T1}}

```snapshot
api                    cts,v1
api-sidecar-proxy      cts,v1
consul                 
web                    v1
web-sidecar-proxy      v1
```

Verify that the `terraform.tfvars` file is now showing the data for the `api` service.

`cat sync-tasks/learn-cts-example/terraform.tfvars`{{execute T1}}

### Verify task events

Finally, you can use the `status/tasks` API resource to verify that the change
generated a Consul-Terraform-Sync event and triggered the task execution.

`curl localhost:8558/v1/status/tasks/learn-cts-example?include=events | jq`{{execute T1}}


