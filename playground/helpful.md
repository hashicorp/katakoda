## Environment

A development Nomad instance is running in the background and will be available to any Nomad command.

Recent versions of HashiCorp Vault, Consul, and Terraform are also installed (but not running).

## Generate a job file
`nomad job init -short`

## Nomad status
`nomad status`{{execute}}

## Run a job
`nomad run [filename]`

## Job status
`nomad status [jobname]`

## Other commands
Nomad CLI help menu: `nomad help`{{execute}}

Terraform CLI help menu: `terraform help`{{execute}}

## Git
Git is also installed in this playground, to clone a repository from GitHub you can use all of the standard git 
commands, for example:
`git clone https://github.com/hashicorp/terraform-container-deploy.git`
