<style type="text/css">
.alert { position: relative; padding: .75rem 1.25rem; margin-bottom: 1rem; border: 1px solid transparent; border-radius: .25rem; }
.alert-dark    { color: #1b1e21; background-color: #d6d8d9; border-color: #c6c8ca; }
.alert-primary { color: #004085; background-color: #cce5ff; border-color: #b8daff; }
.alert-info    { color: #0c5460; background-color: #d1ecf1; border-color: #bee5eb; }
.alert-warning { color: #856404; background-color: #fff3cd; border-color: #ffeeba; }
.alert-danger  { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
.noselect {
  -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Old versions of Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome, Opera and Firefox */
}
</style>

TLS-enabled Nomad clusters configured to perform client validation require that
any client, even Web UI users, present a valid Nomad client certificate. Most
users are more familiar with anonymous TLS, and providing and installing the
client certificates for every UI user could be rather time-consuming.

A reverse proxy is an application that sits in front of one or more web servers,
intercepting requests from clients. This location in the request flow allows for
several benefits:

- **load balancing** - As connections come in to the proxy, it can route them to
  one or more servers. Typically there are several load balancing methodologies,
  including session affinity or "sticky" sessions. This enables operators to
  distribute application traffic over many instances of the application, thus
  increasing its availability.

- **TLS termination/uplift** - Since the proxy server creates a new
  connection on behalf of the user, it can use a different TLS configuration for
  the client-side connection and the server connection. This fact allows
  operators to use a reverse proxy to terminate SSL at the proxy so that
  application traffic is received unencrypted. It also allows a connection to be
  "uplifted" to TLS as it goes from client to proxy to server.

- **application aggregation** - Many proxies provide the ability to route
  inbound requests to more than one backend application based on the hostname
  that the request was sent to or components of the URL's path. This can
  simplify the end user experience when trying to reach applications.

To ensure every feature in the Nomad UI remains fully functional, you must
properly configure your reverse proxy to meet Nomad's specific networking
requirements. In this hands-on lab, you will configure NGINX as a TLS-uplifting reverse
proxy.

This guide will explore common configuration changes necessary when reverse
proxying Nomad's Web UI. Issues common to default proxy configurations will be
discussed and demonstrated. As you learn about each issue, you will deploy NGINX
configuration changes that will address it.
