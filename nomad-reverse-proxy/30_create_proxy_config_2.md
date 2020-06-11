<style type="text/css">
.text-tutorial .step pre code, .side-tutorial .step pre code.lang-nginx {
    overflow-x: scroll;
    white-space: pre;
}
</style>
The Nomad Web UI uses long-lived connections for its live-update feature. If the
proxy closes the connection early because of a connection timeout, it could
prevent the Web UI from continuing to live-reload data.

The Nomad Web UI live-reloads all data to make sure views remain fresh
as the Nomad server's state changes. To do this, the UI performs [blocking queries]
on the Nomad API. Blocking queries are an implementation of long-polling which
works by keeping HTTP connections open until server-side state has changed. This
is advantageous over traditional polling which results in more requests that
often return no new information. It is also faster since a connection will close
as soon as new information is available rather than having to wait for the next
iteration of a polling loop. A consequence of this design is that HTTP requests
aren't always expected to be short-lived.

NGINX has a [default proxy timeout][proxy_read_timeout] of 60 seconds while
Nomad's blocking query system will leave connections open for five minutes by
default. You can observe this by visiting the [Nomad jobs list][jobs] through
the proxy with your browser's developer tools open.

To prevent these timeouts, the NGINX configuration needs to be updated to extend
the `proxy_read_timeout` setting. Add the following to the top of the `location`
block of the existing `nginx.conf`{{open}} file.

<pre class="file" data-filename="nginx.conf" data-target="insert" data-marker="    location / {">
    location / {
      # Nomad blocking queries will remain open for a default of 5 minutes.
      # Increase the proxy timeout to accommodate this timeout with an
      # additional grace period.
      proxy_read_timeout 310s;
</pre>

Restart the NGINX docker container to load these configuration changes.

```shell
docker restart nomad-proxy
```{{execute}}

[proxy_read_timeout]: http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_read_timeout
[jobs]: https://[[HOST_SUBDOMAIN]]-8000-[[KATACODA_HOST]].environments.katacoda.com/ui/jobs
[blocking queries]: https://nomadproject.io/api-docs/#blocking-queries
