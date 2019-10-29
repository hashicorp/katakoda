So far we've created, run and modified a job. The final step in a job lifecycle is stopping the job. This is done with the stop command:

`nomad stop example`{{execute}}

```bash
==> Monitoring evaluation "ddc4eb7d"
    Evaluation triggered by job "example"
    Evaluation within deployment: "ec46fb3b"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "ddc4eb7d" finished with status "complete"
```

When we stop a job, it creates an evaluation which is used to stop all the existing allocations. If we now query the job status, we can see it is now marked as dead (stopped), indicating that the job has been stopped and Nomad is no longer running it:

`nomad status example`{{execute}}

```bash
ID            = example
Name          = example
Submit Date   = 07/26/17 17:51:01 UTC
Type          = service
Priority      = 50
Datacenters   = dc1
Status        = dead (stopped)
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost
cache       0       0         0        0       3         0

Latest Deployment
ID          = ec46fb3b
Status      = successful
Description = Deployment completed successfully

Deployed
Task Group  Desired  Placed  Healthy  Unhealthy
cache       3        3       3        0

Allocations
ID        Node ID   Task Group  Version  Desired  Status    Created At
8ace140d  2cfe061e  cache       2        stop     complete  07/26/17 17:51:01 UTC
8af5330a  2cfe061e  cache       2        stop     complete  07/26/17 17:51:01 UTC
df50c3ae  2cfe061e  cache       2        stop     complete  07/26/17 17:51:01 UTC
```

If we wanted to start the job again, we could simply run it again.

To learn more about Nomad, visit the [Nomad website](https://www.nomadproject.io/guides/index.html).
