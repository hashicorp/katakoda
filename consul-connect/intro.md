
# Consul Connect

In this hands-on lab, you'll start two services and connect them over a TLS encrypted proxy with Consul Connect. Integrating applications with Consul Connect is as easy as talking to a port on `localhost`.

The front end will be a demo dashboard web application that displays a number. The backend will be a counting service that serves a JSON feed with a constantly incrementing number.

The front end uses websockets to update its user interface every few seconds with fresh data from the backend counting service.

You'll spend most of your time executing commands against our demo applications (`dashboard` and `counting`), but Consul works to help services discover each other and connect through encrypted proxies.

We've configured Consul for you and started a single agent, so it's ready to go. Let's get started!
