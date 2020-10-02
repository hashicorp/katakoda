In this scenario, you will experiment with deploying a Nomad job that uses
Consul service mesh in a cluster with ACLs enabled.

The process for enabling service mesh in a cluster is as follows.

1. Setup Consul for service mesh

    1. Enable and bootstrap Consul ACLs
    1. Create Consul agent policy and token
    1. Install Consul agent token
    1. Creating Nomad server policy and token

1. Setup Nomad for service mesh

    1. Configure Nomad with Consul ACL token
    1. Install CNI drivers

1. Run a service mesh job

    1. Create a Connect intention
    1. Run the job
    1. Verify the application is running

1. Require Consul authentication to run jobs

1. Run a service mesh job with a token
