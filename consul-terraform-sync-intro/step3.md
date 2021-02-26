You can verify the configuration is
correct with Consul-Terraform-Sync's inspect mode. The inspect mode allows you examine the changes that your configuration,
run once with Terraform, will apply to your infrastructure. 

Inspect mode will **apply no changes** to your infrastructure but will exit with
a non-zero exit status if any error is encountered.

`consul-terraform-sync -config-file cts-config.hcl -inspect`{{execute T1}}

This will check the configuration for all the tasks in the and
then create a folder in the current directory, named `/sync-tasks`. The folder will contain a Terraform workspace for each task.

`tree sync-tasks/`{{execute T1}}

```snapshot
sync-tasks/
└── learn-cts-example
    ├── main.tf
    ├── terraform.tfvars
    ├── terraform.tfvars.tmpl
    └── variables.tf
``` 

### Terraform installation

From the logs you can confirm that Consul-Terraform-Sync searches for the
Terraform binary. If it does not find one, it installs one in the current path.

```snapshot
[INFO] (driver.terraform) installing terraform to path '/root'
[DEBUG] (driver.terraform) successfully installed terraform 0.14.6: /root/terraform
[INFO] (driver.terraform) successfully installed terraform
```

