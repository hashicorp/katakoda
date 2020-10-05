
## Application Developer persona

First, set the active token to your test app-dev token. You can extract it from
the files that you created earlier.

```
export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' ~/app-dev.token)
```{{execute}}

Create the short sample job with `nomad init`.

```
nomad init -short
```{{execute}}

Submit the sample job to your Nomad cluster.

```
nomad job run example.nomad
```{{execute}}

**Example Output**

```
$ nomad job run example.nomad
==> Monitoring evaluation "0acad62d"
    Evaluation triggered by job "example"
    Allocation "8b54bf75" created: node "afcb4e20", group "cache"
    Evaluation within deployment: "63bbb604"
    Allocation "8b54bf75" status changed: "pending" -> "running" (Tasks are running)
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "0acad62d" finished with status "complete"
```

Verify that the job starts completely using the `nomad job status` command.

```
nomad job status example
```{{execute}}

**Example Output**

```
$ nomad job status example
ID            = example
Name          = example
Submit Date   = 2020-02-10T13:42:17-05:00
Type          = service
Priority      = 50
Datacenters   = dc1
Status        = running
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost
cache       0       0         1        0       0         0

Latest Deployment
ID          = 63bbb604
Status      = running
Description = Deployment is running

Deployed
Task Group  Desired  Placed  Healthy  Unhealthy  Progress Deadline
cache       1        1       0        0          2020-02-10T13:52:17-05:00

Allocations
ID        Node ID   Task Group  Version  Desired  Status   Created  Modified
8b54bf75  afcb4e20  cache       0        run      running  26s ago  25s ago
```

## Production Operator persona

Switch to the prod-ops token.

```
export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' ~/prod-ops.token)
```{{execute}}

Try to stop the job; note that you are unable to do so.

```
nomad stop example
```{{execute}}

**Example Output**

```
$ nomad stop example
Error deregistering job: Unexpected response code: 403 (Permission denied)
```

Switch back to the app-dev token.

```
export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' ~/app-dev.token)
```{{execute}}

Try again to stop the job; note that this time you are successful.

```
nomad stop example
```{{execute}}

**Example Output**

```shell
$ nomad stop example
==> Monitoring evaluation "2571f9f9"
    Evaluation triggered by job "example"
    Evaluation within deployment: "63bbb604"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "2571f9f9" finished with status "complete"
```
