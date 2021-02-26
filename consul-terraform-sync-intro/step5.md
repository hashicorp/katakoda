For operational visibility, you can monitor the state of your tasks with the Consul-Terraform-Sync daemon.

### Use the `status` API 

Consul-Terraform-Sync provides the `/status` REST endpoints to share status-related information 
for tasks. This information is available for understanding the status of 
individual tasks and across tasks.

The health status value is determined by aggregating the success or failure of 
the event of a task detecting changes in Consul services and then updating 
network infrastructure. 

The five most recent events are stored. 

`curl --silent localhost:8558/v1/status | jq`{{execute T1}}

```json
{
  "task_summary": {
    "status": {
      "successful": 1,
      "errored": 0,
      "critical": 0,
      "unknown": 0
    },
    "enabled": {
      "true": 1,
      "false": 0
    }
  }
}
```

### Terraform state in Consul

When using Consul as a backend for Consul-Terraform-Sync, the Terraform state will be persisted in
the Consul KV store as a different state file for each task.

The default path for the state object is `consul-terraform-sync/terraform-env:task-name`
with `task-name` being the task identifer appended to the end of the path.

Using the [Consul UI](https://[[HOST_SUBDOMAIN]]-1443-[[KATACODA_HOST]].environments.katacoda.com/ui/dc1/kv/consul-terraform-sync/) tab you can test the key related to the task is created in Consul.

To view all the content in the UI you will need to login using an ACL token. You 
can use the master token for that.

`echo $CONSUL_HTTP_TOKEN`{{execute T1}}
