# Consul Connect Service Mesh

Consul service mesh secures service-to-service communication with authorization and encryption. Applications can use sidecar proxies in a service mesh configuration to automatically establish TLS connections for inbound and outbound connections without being aware of the network configuration and topology. 

In this hands-on lab, you'll start two services and connect them over a TLS encrypted proxy with Consul service mesh. 

Specifically, you'll start four processes.

- The frontend service is a dashboard that displays a number. 
- The backend service is a counting application that serves a JSON feed with a constantly incrementing number.
- Two `consul connect` sidecar proxies represent the `dashboard` and `counting` services so they can communicate securely with each other.

The frontend service uses websockets to update its user interface every few seconds with fresh data from the backend service. It also displays status information so you can see if the connection can be established.

You'll spend most of your time executing commands against our demo services (`dashboard` and `counting`), but Consul works in the background to help services discover each other and connect through encrypted proxies.

We've configured Consul for you and started a single agent, so it's ready to go. Let's get started!
