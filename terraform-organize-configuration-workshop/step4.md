In this step, you will separate your prod and dev environments into two
directories, each with their own configuration and state.

Ensure that you are still working in the `learn-terraform` directory before
moving on.

```
cd ~/learn-terraform
```{{execute}}

## Create directories

Create directories for your environments.

```
mkdir prod && mkdir dev
```{{execute}}

## Copy configuration

Copy your configuration and "assets/index.html" into the dev directory.

```
cp main.tf outputs.tf variables.tf dev/
mv dev.tfvars dev/terraform.tfvars
mkdir dev/assets
cp assets/index.html dev/assets/
```{{execute}}

Now move the configuration and "assets/index.html" into the `prod` directory.

```
mv main.tf outputs.tf variables.tf prod/
mv prod.tfvars prod/terraform.tfvars
mv assets prod/
```{{execute}}

## Initialize and apply configuration

Now, your configuration is located in two separate directories, and can be
managed independently. Initialize and apply each one.

```
cd dev
terraform init
terraform apply
```{{execute}}

Be sure to respond to the prompt with `yes`{{execute}}.

You can verify the website endpoint URL by opening it in your web browser.

Repeat the same steps to provision your production infrastructure.

```
cd ../prod
terraform init
terraform apply
```{{execute}}

Again, respond to the confirmation prompt with `yes`{{execute}}.

## Destroy resources

After verifying that the infrastructure works as expected, destroy it before
moving on.

```
terraform destroy
```{{execute}}

Respond to the prompt with `yes`{{execute}}.

```
cd ../dev
terraform destroy
```{{execute}}

Once more, respond to the prompt with `yes`{{execute}}.

Now your configuration is independent, and each environment is managed
separately. However, the configuration is almost entirely duplicated between
environments.

In the next step, you will refactor the bucket resource into a module that you
will use in both sets of configuration.
