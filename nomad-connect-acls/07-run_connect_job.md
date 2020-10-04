<style type="text/css">
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

Create a blank job file by running `touch ~/countdash.nomad`{{execute}}. Open
`countdash.nomad`{{open}} in the editor and copy-and-paste this job
specification into the file.

<pre class="file" data-filename="countdash.nomad" data-target="replace">job "countdash" {
   datacenters = ["dc1"]
   group "api" {
     network {
       mode = "bridge"
     }

     service {
       name = "count-api"
       port = "9001"

       connect {
         sidecar_service {}
       }
     }

     task "web" {
       driver = "docker"
       config {
         image = "hashicorpnomad/counter-api:v1"
       }
     }
   }

   group "dashboard" {
     network {
       mode ="bridge"
       port "http" {
         static = 9002
         to     = 9002
       }
     }

     service {
       name = "count-dashboard"
       port = "9002"

       connect {
         sidecar_service {
           proxy {
             upstreams {
               destination_name = "count-api"
               local_bind_port = 8080
             }
           }
         }
       }
     }

     task "dashboard" {
       driver = "docker"
       env {
         COUNTING_SERVICE_URL = "http://${NOMAD_UPSTREAM_ADDR_count_api}"
       }
       config {
         image = "hashicorpnomad/counter-dashboard:v1"
       }
     }
   }
 }
</pre>

### Create the intention

Consul Connect starts in "default-deny" mode in clusters that have ACLs enabled.
You will need to create an intention to allow traffic from the count-dashboard
service to the count-api service.

Run `consul intention create count-dashboard count-api`{{execute}}

**Example Output**

```screenshot
$ consul intention create count-dashboard count-api
Created: count-dashboard => count-api (allow)
```

### Run the job

Run the job by calling `nomad run ~/countdash.nomad`{{execute}}.

**Example Output**

```screenshot
$ nomad run countdash.nomad
==> Monitoring evaluation "3e7ebb57"
    Evaluation triggered by job "countdash"
    Evaluation within deployment: "9eaf6878"
    Allocation "012eb94f" created: node "c0e8c600", group "api"
    Allocation "02c3a696" created: node "c0e8c600", group "dashboard"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "3e7ebb57" finished with status "complete"
```
