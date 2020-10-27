There are a few components that need to be added to the environment; we are
adding them now. Wait for the complete message and then move to the
next step.

**Example Output**

```screenshot
 - Install prerequisites
 - Pulling Docker Image
 - Creating Docker volumes
 - Copying configuration files
 - Starting Consul Server
   ...
 - Configuring Operator Node
 - - Setting Consul as DNS
 - - Installing Applications Locally
 - Starting Consul Clients
   ...
 - Starting Ingress Gateway Node
   ...
 - Starting Applications and configuring service mesh
   ...
 - Apply Configuration Entries
   ...
 - Start Ingress Gateway Instance
```

and concluding with

```
- Complete! Move on to the next step.
```

Once this message appears, you are ready to continue.

### Configuration files

If you are interested in checking the configuration files that are being used to initialize the environment you can find them inside the `config` folder in the editor. Here a list of files with a short description.

| File                            | Description |
|---------------------------------|-------------|
| `agent-server.hcl`              | Server agent config file |
| `agent-client.hcl`              | Client agent config file |
| `svc-api.hcl`                   | Service configuration - `api`|
| `svc-web.hcl`                   | Service configuration - `web`|
| `igw-web.hcl`                   | Ingress Gateway configuration - `web` | 
| `config-service-api.hcl`        | Set protocol for `api` to `http` |
| `config-service-web.hcl`        | Set protocol for `web` to `http` |
| `config-service-counting.hcl`   | Set protocol for `counting` to `http` |
| `config-service-dashboard.hcl`  | Set protocol for `dashboard` to `http` |
| `config-proxy-defaults.hcl`     | Set protocol for Envoy proxies to `http` |
| `config-intentions-default.hcl` | Intention configuration `* => * (deny)` |

You can inspect the full list of configuration files available for the lab with:

`tree .`{{execute T2}}

<!--
| `svc-counting.json`             | Service config - `counting` |
| `svc-dashboard.json`            | Service config - `dashboard` |
| `igw-dashboard.hcl`             | Config entry - ingress GW - `dashboard`| 
-->
<!--
| `config-intentions-api.hcl`     | |
| `config-intentions-web.hcl`     | |

| `agent-server.hcl`        | Server configuration file |
| `agent-client.hcl`        | Client configuration file|
| `default.hcl`             | Service defaults configuration |
| `hash-resolver.hcl`       | Maglev load balancing policy definition |
| `least-req-resolver.hcl`  | Least request load balancing policy definition|
| `svc-client.hcl`          | Service configuration file for `client`|
| `svc-clone.hcl`           | Service configuration file for `backend-clone`|
| `svc-main.hcl`            | Service configuration file for `backend-main`|
| `igw-backend.hcl`         | Ingress Gateway central configuration | 
-->