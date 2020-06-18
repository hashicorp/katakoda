## Production Operator persona

Consider the requirements listed earlier for the production operators
persona. What rules should you add to your policy? Nomad will deny all requests
that are not explicitly supplied, so, again, focus on the policies you would
like to permit.

> Production operators need to be able to perform cluster
maintenance and view workloads, including attached resources like
volumes, in the running cluster. However, because application
developers are the owners of the running workloads, production
operators should not be allowed to run or stop jobs in the cluster.

Recall that [`namespace` rules] govern the job application deployment behaviors
and introspection capabilities for a Nomad cluster.

First, define the policy in terms of required capabilities. What capabilities
from the available options will this policy need to provide to Production
Operators?

| Capability | Desired |
| --- |   ---   |
| **deny** - When multiple policies are associated with a token, deny will take precedence and prevent any capabilities. | N/A |
| **list-jobs** - Allows listing the jobs and seeing coarse grain status. | ✅ |
| **read-job** - Allows inspecting a job and seeing fine grain status. | ✅ |
| **submit-job** - Allows jobs to be submitted or modified. | 🚫 |
| **dispatch-job** - Allows jobs to be dispatched. | 🚫 |
| **read-logs** - Allows the logs associated with a job to be viewed. | 🚫 |
| **read-fs** - Allows the filesystem of allocations associated to be viewed. | 🚫 |
| **alloc-exec** - Allows an operator to connect and run commands in running allocations. | 🚫 |
| **alloc-node-exec** - Allows an operator to connect and run commands in allocations running without filesystem isolation, for example, raw_exec jobs. | 🚫 |
| **alloc-lifecycle** - Allows an operator to stop individual allocations manually. | 🚫 |
| **csi-register-plugin** - Allows jobs to be submitted that register themselves as CSI plugins. | 🚫 |
| **csi-write-volume** - Allows CSI volumes to be registered or deregistered. | 🚫 |
| **csi-read-volume** - Allows inspecting a CSI volume and seeing fine grain status. | ✅ |
| **csi-list-volume** - Allows listing CSI volumes and seeing coarse grain status. | ✅ |
| **csi-mount-volume** - Allows jobs to be submitted that claim a CSI volume. | 🚫 |
| **list-scaling-policies** - Allows listing scaling policies. | 🚫 |
| **read-scaling-policy** - Allows inspecting a scaling policy. | 🚫 |
| **read-job-scaling** - Allows inspecting the current scaling of a job. | 🚫 |
| **scale-job** - Allows scaling a job up or down. | 🚫 |
| **sentinel-override** - Allows soft mandatory policies to be overridden. | 🚫 |

Again, the course-grained `policy` value of a namespace rule is a list of
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

Express this in policy form. Create an file named `prod-ops_policy.hcl`{{open}}
to hold your policy. The capabilities required for the "default" Namespace the
Namespace API are captured with the `read` coarse-grained policy disposition.

<pre class="file" data-filename="prod-ops_policy.hcl" data-target="replace">
namespace "default" {
  policy = "read"
}
</pre>

Operators will also need to have access to several other API endpoints: node,
agent, operator. Consult the individual API documentation for more details on
the endpoints. For this scenario, you can use this rule set.

<pre class="file" data-filename="prod-ops_policy.hcl" data-target="append">
node {
  policy = "write"
}

agent {
  policy = "write"
}

operator {
  policy = "write"
}

plugin {
  policy = "list"
}
</pre>

Add all of these policy elements to your `prod-ops_policy.hcl` file.

[`namespace` rules]: /nomad/acls/policies#namespace-rules
