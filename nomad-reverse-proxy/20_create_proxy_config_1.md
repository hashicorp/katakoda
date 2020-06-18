As mentioned earlier, the goal is to configure a proxy from external Nomad UI
users to the Nomad UI running on the Nomad cluster. To do that, you will
configure an NGINX instance as your reverse proxy.

Create a basic NGINX configuration file to reverse proxy the Web UI. It is
important to name the NGINX configuration file `nginx.conf` otherwise the file
will not bind correctly.

Run `touch nginx.conf`{{execute}}.

Open the `nginx.conf`{{open}} file in the text editor.

<pre class="file" data-filename="nginx.conf" data-target="replace">
# nginx.conf
events {}

http {
  server {
    location / {
      proxy_pass https://[[HOST_IP]]:4646;
      proxy_redirect off;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Nginx-Proxy true;
      proxy_set_header X-Forwarded-Proto https;
      proxy_next_upstream error timeout http_500;
      proxy_ssl_certificate /opt/ssl-certs/global-server-nomad-0.pem;
      proxy_ssl_certificate_key /opt/ssl-certs/global-server-nomad-0-key.pem;
      proxy_ssl_trusted_certificate /opt/ssl-certs/nomad-agent-ca.pem;
      proxy_ssl_name server.global.nomad;
      proxy_ssl_server_name on;
      proxy_ssl_session_reuse on;
    }
  }
}
</pre>

This basic NGINX configuration does the following:

- Forwards all traffic received by NGINX to the Nomad port running on the host

- Adds the `X-Forwarded-For` header to collect the IP address of the requester

- Handles the mTLS connection to Nomad

    - Establishes trust of the Nomad CA certificate
    - Provides a valid mTLS certificate for verification purposes


Start the NGINX docker container. Notice the mount options handle making your
config file and the mTLS certificates available to the container.

```
docker run -d \
  --publish=8000:80 \
  --name="nomad-proxy" \
  --mount type=bind,source=$PWD/nginx.conf,target=/etc/nginx/nginx.conf \
  --mount type=bind,source=/etc/nomad.d/tls,target=/opt/ssl-certs \
  nginx:latest
```{{execute}}

At this point you can visit https://[[HOST_SUBDOMAIN]]-8000-[[KATACODA_HOST]].environments.katacoda.com to connect to the Nomad Web UI through the NGINX reverse proxy.
