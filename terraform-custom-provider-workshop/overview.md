In this workshop, you will add functionality to create, read, update and delete a HashiCups order using a Terraform provider.

This workspace is an Ubuntu image with Terraform 0.15, Go, and a custom environment containing code for the HashiCups provider.

## Explore your development environment

Your development environment contains the following.

- The `Makefile`{{open}} file contains helper functions used to build, package and install the HashiCups provider. The `OS_ARCH` is `linux_amd64`, which matches the katacoda workspace you are building.
- The `docker_compose` directory contains the files required to initialize a local instance of HashiCups.
- The `examples` directory contains sample Terraform configuration that can be used to test the HashiCups provider.
- The `main.go`{{open}} file is the provider's entry point. You will compile this file into a valid, executable Go binary that Terraform Core can consume.
- The `hashicups` directory contains the main provider code. This will be where the provider's resources and data source implementations will be defined.
    - `hashicups/resource_order.go`{{open}} defines `resourceOrder()` and contains boilerplate and comments to guide you through adding CRUD capabilities to an existing provider.

## Katacoda Notes

- Any changes to the file using the file editor will be automatically saved.
- To format your code, run `go fmt ./...`{{execute}} then close and reopen your file.
- Clicking on code snippets with a `Copy to Editor` command will automatically add the code snippet to the correct spot in the file. Use this to speed up your implementation process.
- Click on KataCoda commands to run them automatically in your terminal.
