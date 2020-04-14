In this scenario, we will experiment with deploying a Nomad job that uses Consul
Connect in a cluster with ACLs enabled.

We will do that by:

- Enabling and bootstrapping Consul ACLs

- Creating Consul agent policy and token

- Install Consul agent token

- Creating Nomad server policy and token

- Configure Nomad with Consul token

- Running a Connect-enabled job
  - Creating a Connect intention
  - Running the job
  - Verifying the application is running

- Requiring Consul authentication to run jobs

- Running a Connect-enabled job with a token

