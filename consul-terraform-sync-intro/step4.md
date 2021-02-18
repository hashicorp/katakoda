After inspecting the configuration for the tasks you can run Consul-Terraform-Sync
using the daemon mode.

This is the default mode. In this mode Consul-Terraform-Sync passes through a 
once-mode phase, in which it will try to run all the tasks once, and then turns 
into a long running process. During the once-mode phase, the daemon will exit 
with a non-zero status if it encounters an error. After successfully passing 
through once-mode phase, errors will be logged and the process is not expected 
to exit.

Move to another terminal, dedicated to Consul-Terraform-Sync and check if the
token is set in the environment variable.

`echo $CONSUL_HTTP_TOKEN`{{execute T2}}

If the above command returns an empty result, configure the environment 
variables for the new terminal.

`source consul_env.conf`{{execute T2}}

Once the environment variables are set you can run Consul-Terraform-Sync.

`consul-terraform-sync -config-file cts-config.hcl`{{execute T2}}

After startup, CTS will run Terraform, and create a folder, named `sync-tasks`, 
inside the `working_directory` defined in the configuration for each task ran by 
CTS. If no working directory has been configured Terraform will create the 
folder in the directory from which CTS is started.

Inside the `<working_directory>/sync-tasks` folder Terraform will create a 
workspace for each task defined in the configuration.

`tree sync-tasks/`{{execute T1}}

```snapshot
sync-tasks/
└── learn-cts-example
    ├── addresses.txt
    ├── main.tf
    ├── terraform.tfvars
    ├── terraform.tfvars.tmpl
    ├── variables.tf
    └── web.txt
```

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


After the task execution the two extra files `addresses.txt` and `web.txt` will 
be created. They contain the IPs for the services matched by the task.

To get the full amount of data Consul-Terraform-Sync is collecting from Consul
catalog you can inspect the `terraform.tfvars` file.

`cat sync-tasks/learn-cts-example/terraform.tfvars`{{execute T1}}

