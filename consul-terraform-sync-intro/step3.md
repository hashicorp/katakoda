Once the configuration file is complete you can verify the configuration is
correct by using one of the Consul-Terraform-Sync execution mode, the inspect mode.

Inspect mode is designed to help you examine the changes that your configuration,
once ran via Terraform, will apply to your infrastructure. Running CTS in 
inspect mode will **apply no changes** to your infrastructure but will exit with
a non-zero exit status if any error is encountered.

`consul-terraform-sync -config-file cts-config.hcl -inspect true`{{execute T1}}

This will inspect the configuration for all the tasks in the configuration and
create the a folder in the current directory, named `/sync-tasks` in which 
Terraform will create a workspace for each task defined in the configuration.

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

From the logs you can confirm that the Consul-Terraform-Sync tools looks for the
Terraform binary and in case it does not find it installs it in the current path.

```snapshot
[INFO] (driver.terraform) installing terraform to path '/root'
[DEBUG] (driver.terraform) successfully installed terraform 0.14.6: /root/terraform
[INFO] (driver.terraform) successfully installed terraform
```

In case Terraform is already present on the system or was installed from a 
previous run, CTS will be able to detect it and skip the installation.

```snapshot
[INFO] (driver.terraform) skipping install, terraform 0.14.6 already exists at path /root/terraform
```