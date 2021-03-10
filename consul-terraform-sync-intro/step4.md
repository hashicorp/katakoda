After checking the configuration for the tasks, you can run Consul-Terraform-Sync in daemon mode, which is the default mode. In this mode, Consul-Terraform-Sync passes through a 
once-mode phase. 

The once-mode phase will run all the tasks once and then becomes a long running process. 

#### Start Consul-Terraform-Sync in daemon mode

Move to the terminal dedicated to Consul-Terraform-Sync and set
the token as an environment variable.

`source consul_env.conf`{{execute T2}}

Once the environment variables are set, you can run Consul-Terraform-Sync.

`consul-terraform-sync -config-file cts-config.hcl`{{execute T2}}

After startup, Consul-Terraform-Sync will:

1. run Terraform 
1. create a folder, named `sync-tasks`
 
The folder will be created in the directory where Consul-Terraform-Sync was started and represents the `working_directory` for Terraform.

Inside the `sync-tasks` folder Terraform will create a 
workspace for each task defined in the configuration.

`tree sync-tasks/`{{execute T1}}

```snapshot
sync-tasks/
└── learn-cts-example
    ├── main.tf
    ├── terraform.tfvars
    ├── terraform.tfvars.tmpl
    ├── variables.tf
    └── web.txt
```

After the task execution the two extra files `addresses.txt` and `web.txt` will 
be created. They contain the IPs for the services matched by the task.

- `main.tf`: contains the terraform block, provider blocks, and a module block 
calling the module configured for the task.
- `variables.tf`: contains the services input variable which determines module 
compatibility with Consul-Terraform Sync and optionally the intermediate 
variables used to dynamically configure providers.
- `terraform.tfvars`: is where the services input variable is assigned values 
from the Consul catalog. It is periodically updated to reflect the current state
of the configured set of services for the task. 
- `terraform.tfvars.tmpl`:  is used to template the information retrieved from
Consul catalog into the `terraform.tfvars` file.

To get the full amount of data Consul-Terraform-Sync collects from the Consul
catalog you can inspect the `terraform.tfvars` file.

`cat sync-tasks/learn-cts-example/terraform.tfvars`{{execute T1}}
