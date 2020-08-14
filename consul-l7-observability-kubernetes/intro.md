Consul service mesh deploys an Envoy sidecar proxy alongside each service instance in a datacenter.
The sidecar proxy brokers traffic between the local service instance and other services registered
with Consul. The proxy is aware of all traffic that passes through it. In addition to securing
inter-service traffic, the proxy can also collect and expose data about the service instance.
Consul service mesh is able to configure Envoy to expose layer 7 metrics, such as HTTP status
codes or request latency, to monitoring tools like Prometheus.

In this tutorial, you will:

- Deploy Consul using the official helm chart.
- Deploy Prometheus and Grafana using their official Helm charts.
- Deploy a multi-tier demo application that is configured to be scraped by Prometheus.
- Start a traffic simulation deployment, and observe the application traffic in Grafana.
