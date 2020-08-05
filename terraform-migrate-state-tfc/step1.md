# Initialize a Local Terraform Configuration

This Terraform config uses the [random_pet](https://www.terraform.io/docs/providers/random/r/pet.html) provider to generate a random name like `endless-mastodon` or `feasible-cougar`. It doesn't require any credentials and it won't cost any money to run.

Change into the project directory:

`cd ~/learn-state-migration`{{execute}}

Initialize the project:

`terraform init`{{execute}}

Apply the configuration. You'll be asked to confirm by typing "yes", and then the name of an animal will be printed as an output.

`terraform apply`{{execute}}

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_pet.server: Creating...
random_pet.server: Creation complete after 0s [id=feasible-cougar]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

random_server_id = feasible-cougar
```

In the next step, you'll migrate this configuration to Terraform Cloud to leverage remote execution and remote state storage.