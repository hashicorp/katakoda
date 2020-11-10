A synthetic check allows Datadog to check a specific URL at intervals of your choice. If the URL times out or does not return the expected value you will be alerted.

Open the `datadog_synthetics.tf`{{open}} file.

To view the service in action, click the "View Beacon" tab in the Katacoda scenario or go to [this link](https://[[HOST_SUBDOMAIN]]-30201-[[KATACODA_HOST]].environments.katacoda.com/) directly. Copy the path to this site.

Apply your configuration to create a new synthetic monitor. Remember to confirm your apply with a `yes`.

`terraform apply`{{execute}}
