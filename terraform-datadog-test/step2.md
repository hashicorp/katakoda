Open the `helm_datadog.tf`{{open}} file. This file contains the resources and metadata for your nodes to report to Datadog. Review the configuration below.

This Helm configuration requires your Datadog API and application keys. Set these values as environment variables in the Katacoda terminal.

Run the following command, replacing `<Your-API-Key>` with your Datadog API key you saved earlier.

`export TF_VAR_datadog_api_key="<Your-API-Key>"`{{copy}}

Repeat this process with the application  key. Replace `<Your-App-Key>` with your Datadog application key you saved earlier.

`export TF_VAR_datadog_app_key="<Your-App-Key>"`{{copy}}


Add variables for your Datadog keys to the  `variables.tf`{{open}} file.

```
variable "datadog_api_key" {
  type = string
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type = string
  description = "Datadog Application Key"
}
```{{copy}}

Apply your configuration to create a new Helm release. Remember to confirm your apply with a `yes`.

`terraform apply`{{execute}}
