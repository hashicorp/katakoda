This is the workspace for the Terraform [**Build a Custom Terraform Provider Workshop**](https://hashiconf.com/digital-october/workshops?workshop=terraform-build-a-custom-terraform-provider) and contains the latest version of Terraform CLI and HashiCups provider.

In this workshop, you will modify an existing Terraform provider to add create, read, update and delete (CRUD) functionality to a new resource. This workshop comprises of seven main steps, estimated to take a total of 45 minutes.

1. Map target resource's data model to a Terraform schema type
1. Add create functionality to a resource
1. Add complex read functionality (with flattening functions) to a resource
1. Add update functionality to a resource
1. Add delete functionality to a resource
1. Build provider
1. Apply configuration with new resource to test implementation
<!-- 1. \[Optional\] Publish to Terraform Registry -->

Most of the implementation for each step is provided for you. This workshop and the commented code will guide you to complete the remaining portion of each step.

These sections will start the following in a code comment.

```
\\ ** |
```

By the end of this workshop, you should understand how to use the Terraform Plugin SDK v2 to map target APIs to Terraform to create, read, update and delete (CRUD) resources.