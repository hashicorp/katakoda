# Organize Terraform Configuration

In this tutorial, you will organize Terraform configuration by starting with an
example monolithic project that manages static websites hosted in AWS S3, and
refactoring it using four strategies:

1. Split the configuration into multiple files
1. Separate state with Terraform Workspaces
1. Separate the configuration into separate project directories
1. Refactor and simplify the configuration using a module

> This environment has been pre-configured with the Terraform CLI, AWS CLI and 
[localstack](https://localstack.cloud/), a mocking framework that mocks core 
AWS APIs locally. As a result, you do not need an AWS account to complete this scenario.