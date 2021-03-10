This lab comes with a pre-compiled configuration file, `cts-config.hcl`{{open}}. Open the file to view the contents. 

The file is divided into five different sections.

#### Global section

Top level options are reserved for configuring the Consul-Terraform-Sync daemon. In this section you can configure the log level to use for Consul-Terraform-Sync
logging as well as the port used by the demon to offer the API interface.

#### Consul block

The Consul block is used to configure the connection between Consul-Terraform-Sync daemon and the  
Consul client agent. The enables the Consul-Terraform-Sync daemon to perform queries to the Consul catalog and Consul KV pertaining 
to task execution.

In this lab, you are connecting to the Consul agent over HTTP on `localhost` so no 
certificate is required and you are passing the token using the 
`CONSUL_HTTP_TOKEN` variable so no other information is required in the 
configuration file.

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>

In a fully secured environment, with mTLS and ACLs enabled, you 
can use this section to include the certificates and token required by Consul-Terraform-Sync to
securely communicate with Consul. The same information can also be provided 
using environment variables, such as `CONSUL_HTTP_TOKEN` for the ACL token, to
avoid having sensitive data in your configuration file.

</p></div>

#### Driver “terraform” block

The driver block configures the subprocess used by Consul-Terraform-Sync to 
propagate infrastructure change. The Terraform driver is a required 
configuration for Consul-Terraform-Sync to relay provider discovery and 
installation information to Terraform.

#### Service block

A `service` block is an optional block to explicitly define configuration of 
services that Consul-Terraform-Sync monitors. A `service` block is only necessary 
for services that have non-default values (e.g. custom tags).

```hcl
service {
 name = "api"
 tag = "cts"
 # namespace = "my-team"
 # datacenter  = "dc1"
 description = "Match only services with a specific tag"
}
```

For example, in the code snippet above, you are defining a service block 
matching instances of the `api` service that also have `cts` as a tag.

#### Task block

A task is executed when any change of information for services the task is 
configured for is detected from the Consul catalog. Execution could include one 
or more changes to service values, like IP address, added or removed service 
instance, or tags.

```hcl
task {
 name        = "learn-cts-example"
 description = "Example task with two services"
 source      = "findkim/print/cts"
 version     = "0.1.0"
 services    = ["web", "api"]
}
```

For example, in the code snippet above, you are defining a task block that will
monitor and react to changes on `web` and `api` services and run the module
defined in the `source` parameter when any change is detected.
 