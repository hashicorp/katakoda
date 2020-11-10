Open the `datadog_dashboard.tf`{{open}} file. This file contains the resources to create an easily accessible dashboard for your Beacon deployment monitors in the Datadog UI. This is useful if you have several monitors and need to group them together for visibility.

Apply your configuration to create a new Datadog dashboard for your metrics and synthetics monitors. Remember to confirm your apply with a `yes`.

`terraform apply`{{execute}}
