> Click the command (`⮐`) to automatically copy it into the terminal and execute it.

Before start, verify that `main.tf` file exists.

```
ls -al | grep main.tf
```{{execute T1}}

<div style="background-color:#fbe5e5; color:#864242; border:1px solid #f8cfcf; padding:1em; border-radius:3px; margin:24px 0;">
<p>
If `main.tf` does not exist, wait for additional 5~10 seconds and try again. Once the file is copied over, you are ready to start!
</p></div>

The first step in this lab is to use Terraform to start the containers.

You will do this with 3 `terraform` commands, which accomplish the following tasks:

1. Initialize the Terraform configuration
1. Define a plan
1. Apply the defined plan

Once the plan is applied, the infrastructure will be fully configured and ready to go after the Splunk provisioning completes. The entire process usually requires approximately 4 minutes time.

Begin by initializing the Terraform configuration.

```shell
terraform init
```{{execute T1}}

Successful output includes the message "**Terraform has been successfully initialized!**". If instead you encounter an error about terraform missing or a message like "Terraform initialized in an empty directory!", try the command once again.

Next, define a plan that will be written to the file `vault-metrics-lab.plan`.

```shell
terraform plan -out vault-metrics-lab.plan
```{{execute T1}}

If this step is successful you will find the following message in the `terraform` output.

```shell
This plan was saved to: vault-metrics-lab.plan
```

Finally, apply the plan.

> **NOTE: The apply process can require more than 3 minutes to complete.** The moment after you apply the plan would be a great time to grab a fresh beverage or take a short break.

```shell
terraform apply vault-metrics-lab.plan
```{{execute T1}}

If all goes according to plan, you should observe an "Apply complete!" message like this in the output.

```shell
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
```

Although Terraform has succeeded in deploying the infrastructure, the vtl-splunk container will still be provisioning and that takes additional time. To wait for Splunk to become fully ready with a **healthy** status, use this command.

```shell
export splunk_ready=0
while [ $splunk_ready = 0 ]
  do
    if docker ps -f name=vtl-splunk --format "{{.Status}}" \
    | grep -q '(healthy)'
        then
            export splunk_ready=1
            echo "Splunk is ready."
        else
            printf "."
    fi
    sleep 5s
done
```{{execute T1}}

You can also manually confirm the container status with `docker ps` like this.

```shell
docker ps -f name=vtl --format "table {{.Names}}\t{{.Status}}"
```{{execute T1}}

Output should resemble this example.

```plaintext
NAMES               STATUS
vtl-splunk          Up About a minute (healthy)
vtl-vault           Up About a minute (unhealthy)
vtl-telegraf        Up 2 minutes
```

> **NOTE:** The Vault container, vtl-vault is listed as **unhealthy** when it is sealed; in this case, you have not yet initialized or unsealed Vault, so the status is correct and expected.

Once your vtl-splunk container has a healthy status, click **Continue** to proceed to step 2, where you will initialize and unseal Vault, then login to begin using it.
