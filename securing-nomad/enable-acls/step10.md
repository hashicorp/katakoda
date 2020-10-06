In this hands-on lab, you will create Nomad ACL policies to provide controlled
access for two different personas to your Nomad Cluster. You will use the sample
job created with the `nomad init -short` command as a sample job. These personas
are contrived to suit the scenario. You should design your ACL policies around your
organization's specific needs.

As a best practice, access should be limited as much as possible given the needs
of the user's roles.

## Meet the personas

**Application Developers**

Application developers need to be able to deploy applications into the
Nomad cluster and control their lifecycles. They should not be able to perform any
other node operations.

Application developers are allowed to fetch logs from their running containers,
but should not be allowed to run commands inside of them or access the
filesystem for running workloads.

**Production Operators**

Production operators need to be able to perform cluster
maintenance and view workloads, including attached resources like
volumes, in the running cluster. However, because application
developers are the owners of the running workloads, production
operators should not be allowed to run or stop jobs in the cluster.
