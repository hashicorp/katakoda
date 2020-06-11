Create a service job file that will frequently write logs to `stdout`. This sample job file below can be used if you don't have your own.

Open a file named `fs-example.nomad`{{open}}

<pre class="file" data-filename="fs-example.nomad" data-target="replace">
# fs-example.nomad

job "fs-example" {
  datacenters = ["dc1"]

  task "fs-example" {
    driver = "docker"

    config {
      image = "dingoeatingfuzz/fs-example:0.3.0"
    }

    resources {
      cpu    = 100
      memory = 100
    }
  }
}
</pre>

Run this service job using the Nomad CLI or UI.

```bash
nomad run fs-example.nomad
```{{execute}}

At this point, you have a Nomad cluster running locally with one job in it. You
can visit the Web UI at <http://[[HOST_SUBDOMAIN]]-4646-[[KATACODA_HOST]].environments.katacoda.com>.
