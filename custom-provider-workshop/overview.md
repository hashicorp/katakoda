In this workshop, you will add functionality to create, read, update and delete a HashiCups order using a Terraform provider.

This workspace is an Ubuntu image with Terraform 0.13, Go, and a custom environment containing code for the HashiCups provider.

## Explore your development environment

Your development environment contains the following.

- `Makefile`{{open}} contains helper functions used to build, package and install the HashiCups provider. The `OS_ARCH` has been updated to `linux_amd64` to match the workspace's.
- `docker_compose` contains the files required to initialize a local instance of HashiCups.
- `examples` contains sample Terraform configuration that can be used to test the HashiCups provider.
- `main.go`{{open}} is the main entry point. This file creates a valid, executable Go binary that Terraform Core can consume.
- `hashicups` contains the main provider code. This will be where the provider's resources and data source implementations will be defined.

`hashicups/resource_order.go`{{open}} defines `resourceOrder()` and contains boilerplate and comments to guide you through adding CRUD capabilities to an existing provider.

## Katacoda Notes

Any changes to the file using the file editor will be automatically saved.

## Initialize your developer environment

First, run the `go mod init` command to define this directory as the root of a module.

`go mod init terraform-provider-hashicups`{{execute}}

Then, run go mod vendor to create a vendor directory that contains all the provider's dependencies.

`go mod vendor`{{execute}}

## Add `order` resource to provider

Open `hashicups/provider.go`{{open}}.  Add the `order` resource to the provider's `ResourceMap` (line 32).

```
"hashicups_order": resourceOrder(),
```