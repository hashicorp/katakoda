# What is OpenFaaS

OpenFaaS is a private Functions-as-a-Service (FaaS) platform which you can run
on your existing scheduler such as Nomad, Kubernetes, and Docker Swarm. It
brings the convenience and efficacy of a function based workflow for developers
while providing a lower operational impact.

## Useful URLs

### Local Docker registry

<https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/v2>

### OpenFaaS gateway

<https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/>

## Architecture

OpenFaaS is built around Docker, all functions are just Docker images which
immediately gives a familiar workflow.

The three core components consist of a gateway, a provider, and a monitoring
element. The gateway is the external API which allows the administration and
execution of functions. It does not directly interact with your scheduler, but
delegates this responsibility to a provider which can trigger function
deployments and scale functions. Both the gateway and the provider emit metrics
such as invocation count and timing data for a function which is collected by
Prometheus.

Besides being an excellent way of monitoring your system Prometheus also has the
capability of broadcasting alerts based on the stored metrics. This capability
allows the gateway to listen for these alerts and react to them. A common
example of this is to automatically trigger the scaling of a function based on
load.

![](https://github.com/hashicorp/faas-nomad/raw/master/images/openfaas_nomad.png)

## Nomad

The OpenFaaS gateway and the Nomad provider has already been deployed to the
scheduler, the details of the job can be found in
[`hashicorp/faas-nomad/nomad_job_files/fass.hcl`][fass.hcl].

If you run the `nomad status` command, you should see the details of the job.

`nomad job status faas-nomadd`{{execute}}

You should also be able to see the Nomad UI and the OpenFaaS UI by clicking on
the tabs at the top of the terminal window.

[fass.hcl]: https://raw.githubusercontent.com/hashicorp/faas-nomad/master/nomad_job_files/faas.hcl