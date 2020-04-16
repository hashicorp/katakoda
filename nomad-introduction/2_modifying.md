The definition of a job is not static, and is meant to be updated over time. You may update a job to change the docker container, to update the application version, or to change the count of a task group to scale with load. Open the Nomad job file by clicking on this link.

`example.nomad`{{open}}

Find a line labeled `group "cache"` in the example.nomad file and add `count = 3` under it. This will run three instances of redis.

```bash
group "cache" {
  count = 3
}
```

The "count" parameter specifies the number of the task groups that should
be running under this group. This value must be non-negative and defaults
 to 1.

`count = 3`

In order to run smoothly, find the line `memory = 256` and change it to `32` so that each redis instance runs with less memory (for the purposes of this demo).

```bash
memory = 32
```

Once you have finished modifying the job specification, use the plan command to invoke a dry-run of the scheduler to see what would happen if you ran the updated job:

`nomad plan example.nomad`{{execute}}

```bash
+/- Job: "example"
+/- Task Group: "cache" (2 create, 1 in-place update)
  +/- Count: "1" => "3" (forces create)
      Task: "redis"

Scheduler dry-run:
- All tasks successfully allocated.

Job Modify Index: 6
To submit the job with version verification run:

nomad run -check-index 6 example.nomad
```


We can see that the scheduler detected the change in count and informs us that it will cause 2 new instances to be created. The in-place update that will occur is to push the update job specification to the existing allocation and will not cause any service interruption. We can then run the job with the run command the plan emitted.

`nomad run example.nomad`{{execute}}

```bash
==> Monitoring evaluation "127a49d0"
    Evaluation triggered by job "example"
    Evaluation within deployment: "2e2c818f"
    Allocation "8ab24eef" created: node "171a583b", group "cache"
    Allocation "f6c29874" created: node "171a583b", group "cache"
    Allocation "8ba85cef" modified: node "171a583b", group "cache"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "127a49d0" finished with status "complete"
```

Because we set the count of the task group to three, Nomad created two additional allocations to get to the desired state. It is idempotent to run the same job specification again and no new allocations will be created.

`nomad status example`{{execute}}

Now, let's try to do an application update. In this case, we will simply change the version of redis we want to run. Edit the example.nomad file and change the Docker image from `redis:3.2` to `redis:4.0`:

```bash
# Configure Docker driver with the image
config {
    image = "redis:4.0"
}
```

We can run plan again to see what will happen if we submit this change:

`nomad plan example.nomad`{{execute}}

```bash
+/- Job: "example"
+/- Task Group: "cache" (1 create/destroy update, 2 ignore)
  +/- Task: "redis" (forces create/destroy update)
    +/- Config {
      +/- image:           "redis:3.2" => "redis:4.0"
          port_map[0][db]: "6379"
        }

Scheduler dry-run:
- All tasks successfully allocated.
- Rolling update, next evaluation will be in 10s.

Job Modify Index: 42
To submit the job with version verification run:

nomad run -check-index 42 example.nomad
```

Here we can see the plan reports it will ignore two allocations and do one create/destroy update which stops the old allocation and starts the new allocation because we have changed the version of redis to run.

The reason the plan only reports a single change will occur is because the job file has an update stanza that tells Nomad to perform rolling updates. We are setting the update attribute in our example file to 1, this means that Nomad will update one allocation
and wait for it to be marked as healthy before it will update the next allocation.

Once ready, use run to push the updated specification:

`nomad run example.nomad`{{execute}}

```bash
==> Monitoring evaluation "02161762"
    Evaluation triggered by job "example"
    Evaluation within deployment: "429f8160"
    Allocation "de4e3f7a" created: node "6c027e58", group "cache"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "02161762" finished with status "complete"
```

After running, the rolling upgrade can be followed by running `nomad status example`{{execute}} and watching the deployed count.

We can see that Nomad handled the update in three phases, only updating a single allocation in each phase and waiting for it to be healthy for `min_healthy_time` of 5 seconds before moving on to the next. The update strategy can be configured, but rolling updates makes it easy to upgrade an application at large scale.
