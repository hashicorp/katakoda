Open the `datadog_metrics.tf`{{open}} file. This final configuration file will report threshold errors in the Kubernetes pods and report errors if anyone or more of the pods go down.

The `datadog_monitor.beacon` resource notifies and escalates the health of the Kubernetes "beacon" application. The [`query`](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor#query) argument is how Datadog communicates with the pods. If all three pods are operational, they report as "OK";if any pods goes down, it will warn the main user.

Apply your configuration to create a new Datadog monitor. Remember to confirm your apply with a `yes`.


`terraform apply`{{execute}}
