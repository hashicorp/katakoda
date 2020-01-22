# Consul Connect

In this hands-on lab, you'll start two services and connect them over a TLS encrypted proxy with Consul Connect. Integrating applications with Consul Connect is as easy as talking to a port on `localhost`.

In this demo, you'll start four processes.

- The front end will be a demo dashboard web application that displays a number. 
- The backend will be a counting service that serves a JSON feed with a constantly incrementing number.
- Two `consul connect` proxies represent the `dashboard` and `counting` services so they can communicate securely with each other.

The front end uses websockets to update its user interface every few seconds with fresh data from the backend counting service. It also displays status information so you can see when the connection has been made.

You'll spend most of your time executing commands against our demo applications (`dashboard` and `counting`), but Consul works in the background to help services discover each other and connect through encrypted proxies.

We've configured Consul for you and started a single agent, so it's ready to go. Let's get started!
