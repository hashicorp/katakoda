## Application Developer persona

Considering the requirements listed earlier. What rules should you add to your
policy? Nomad will deny all requests that are not explicitly permitted, so focus
on the policies and capabilities you would like to permit.

However, be mindful of the course-grained permissions in `namespace` rules—they
might grant more permissions than you need for your use case.

> Application developers need to be able to deploy applications into the
Nomad cluster and control their lifecycles. They should not be able to perform any
other node operations.
>
> Application developers are allowed to fetch logs from their running containers,
but should not be allowed to run commands inside of them or access the filesystem for running workloads.

Recall that [`namespace` rules] govern job application deployment behaviors
and introspection capabilities for a Nomad cluster.

First, define the policy in terms of required capabilities. What capabilities
from the available options will this policy need to provide to Application
Developers?

| Capability | Desired |
| --- |   ---   |
| **deny** - When multiple policies are associated with a token, deny will take precedence and prevent any capabilities. | N/A |
| **list-jobs** - Allows listing the jobs and seeing coarse grain status. | ✅ |
| **read-job** - Allows inspecting a job and seeing fine grain status. | ✅ |
| **submit-job** - Allows jobs to be submitted or modified. | ✅ |
| **dispatch-job** - Allows jobs to be dispatched. | ✅ |
| **read-logs** - Allows the logs associated with a job to be viewed. | ✅ |
| **read-fs** - Allows the filesystem of allocations associated to be viewed. | 🚫 |
| **alloc-exec** - Allows an operator to connect and run commands in running allocations. | 🚫 |
| **alloc-node-exec** - Allows an operator to connect and run commands in allocations running without filesystem isolation, for example, raw_exec jobs. | 🚫 |
| **alloc-lifecycle** - Allows an operator to stop individual allocations manually. | 🚫 |
| **csi-register-plugin** - Allows jobs to be submitted that register themselves as CSI plugins. | 🚫 |
| **csi-write-volume** - Allows CSI volumes to be registered or deregistered. | 🚫 |
| **csi-read-volume** - Allows inspecting a CSI volume and seeing fine grain status. | 🚫 |
| **csi-list-volume** - Allows listing CSI volumes and seeing coarse grain status. | 🚫 |
| **csi-mount-volume** - Allows jobs to be submitted that claim a CSI volume. | 🚫 |
| **list-scaling-policies** - Allows listing scaling policies. | 🚫 |
| **read-scaling-policy** - Allows inspecting a scaling policy. | 🚫 |
| **read-job-scaling** - Allows inspecting the current scaling of a job. | 🚫 |
| **scale-job** - Allows scaling a job up or down. | 🚫 |
| **sentinel-override** - Allows soft mandatory policies to be overridden. | 🚫 |

Remember that the course-grained `policy` value of a namespace rule is a list of
capabilities.

<!-- markdownlint-disable no-inline-html -->
| policy value | capabilities |
| --- | --- |
| `deny` | deny |
| `read` | list-jobs<br />read-job<br />csi-list-volume<br />csi-read-volume<br />list-scaling-policies<br />read-scaling-policy<br />read-job-scaling |
| `write` | list-jobs<br />read-job<br />submit-job<br />dispatch-job<br />read-logs<br />read-fs<br />alloc-exec<br />alloc-lifecycle<br />csi-write-volume<br />csi-mount-volume<br />list-scaling-policies<br />read-scaling-policy<br />read-job-scaling<br />scale-job |
| `scale` | list-scaling-policies<br />read-scaling-policy<br />read-job-scaling<br />scale-job|
| `list` | (grants listing plugin metadata only) |
<!-- markdownlint-restore -->

Express this in policy form. Create a file named `app-dev_policy.hcl`{{open}} to write
your policy.

<pre class="file" data-filename="app-dev_policy.hcl" data-target="replace">
namespace "default" {
  policy = "read"
  capabilities = ["submit-job","dispatch-job","read-logs"]
}
</pre>

Note that the namespace rule has `policy = "read"`. The **write** policy is not
suitable because it is overly permissive, granting "read-fs", "alloc-exec", and
"alloc-lifecycle".

[`namespace` rules]: https://learn.hashicorp.com/nomad/acls/policies#namespace-rules
