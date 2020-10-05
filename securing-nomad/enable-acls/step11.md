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

<details><summary>View Answer</summary>

<table>
  <thead>
    <tr><th>Capability</th><th>Desired</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>deny</strong> - When multiple policies are associated with a token, deny will take precedence and prevent any capabilities. </td><td> N/A </td></tr>
    <tr><td><strong>list-jobs</strong> - Allows listing the jobs and seeing coarse grain status. </td><td> ✅ </td></tr>
    <tr><td><strong>read-job</strong> - Allows inspecting a job and seeing fine grain status. </td><td> ✅ </td></tr>
    <tr><td><strong>submit-job</strong> - Allows jobs to be submitted or modified. </td><td> ✅ </td></tr>
    <tr><td><strong>dispatch-job</strong> - Allows jobs to be dispatched. </td><td> ✅ </td></tr>
    <tr><td><strong>read-logs</strong> - Allows the logs associated with a job to be viewed. </td><td> ✅ </td></tr>
    <tr><td><strong>read-fs</strong> - Allows the filesystem of allocations associated to be viewed. </td><td> 🚫 </td></tr>
    <tr><td><strong>alloc-exec</strong> - Allows an operator to connect and run commands in running allocations. </td><td> 🚫 </td></tr>
    <tr><td><strong>alloc-node-exec</strong> - Allows an operator to connect and run commands in allocations running without filesystem isolation, for example, raw_exec jobs. </td><td> 🚫 </td></tr>
    <tr><td><strong>alloc-lifecycle</strong> - Allows an operator to stop individual allocations manually. </td><td> 🚫 </td></tr>
    <tr><td><strong>csi-register-plugin</strong> - Allows jobs to be submitted that register themselves as CSI plugins. </td><td> 🚫 </td></tr>
    <tr><td><strong>csi-write-volume</strong> - Allows CSI volumes to be registered or deregistered. </td><td> 🚫 </td></tr>
    <tr><td><strong>csi-read-volume</strong> - Allows inspecting a CSI volume and seeing fine grain status. </td><td> 🚫 </td></tr>
    <tr><td><strong>csi-list-volume</strong> - Allows listing CSI volumes and seeing coarse grain status. </td><td> 🚫 </td></tr>
    <tr><td><strong>csi-mount-volume</strong> - Allows jobs to be submitted that claim a CSI volume. </td><td> 🚫 </td></tr>
    <tr><td><strong>list-scaling-policies</strong> - Allows listing scaling policies. </td><td> 🚫 </td></tr>
    <tr><td><strong>read-scaling-policy</strong> - Allows inspecting a scaling policy. </td><td> 🚫 </td></tr>
    <tr><td><strong>read-job-scaling</strong> - Allows inspecting the current scaling of a job. </td><td> 🚫 </td></tr>
    <tr><td><strong>scale-job</strong> - Allows scaling a job up or down. </td><td> 🚫 </td></tr>
    <tr><td><strong>sentinel-override</strong> - Allows soft mandatory policies to be overridden. </td><td> 🚫 </td></tr>
  </tbody>
</table>
<br /><br />
Remember that the course-grained `policy` value of a namespace rule is a list of
capabilities.

<!-- markdownlint-disable no-inline-html -->
<table>
  <thead>
    <tr><th> Policy value </th><th> Capabilities </th></tr>
  </thead>
  <tbody>
    <tr><td><code>deny</code></td><td>deny </td></tr>
    <tr><td><code>read</code></td><td>list-jobs<br />read-job<br />csi-list-volume<br />csi-read-volume<br />list-scaling-policies<br />read-scaling-policy<br />read-job-scaling </td></tr>
    <tr><td><code>write</code></td><td>list-jobs<br />read-job<br />submit-job<br />dispatch-job<br />read-logs<br />read-fs<br />alloc-exec<br />alloc-lifecycle<br />csi-write-volume<br />csi-mount-volume<br />list-scaling-policies<br />read-scaling-policy<br />read-job-scaling<br />scale-job </td></tr>
    <tr><td><code>scale</code></td><td>list-scaling-policies<br />read-scaling-policy<br />read-job-scaling<br />scale-job</td></tr>
    <tr><td><code>list</code></td><td>(grants listing plugin metadata only) </td></tr>
  </tbody>
</table>
<!-- markdownlint-restore -->

</details>

Express this in policy form. Create a file named `app-dev_policy.hcl`{{open}} to write
your policy.

<details><summary>View policy content</summary>

<pre class="file" data-filename="app-dev_policy.hcl" data-target="replace">
namespace "default" {
  policy = "read"
  capabilities = ["submit-job","dispatch-job","read-logs"]
}
</pre>

Note that the namespace rule has `policy = "read"`. The **write** policy is not
suitable because it is overly permissive, granting "read-fs", "alloc-exec", and
"alloc-lifecycle".

</details>

[`namespace` rules]: https://learn.hashicorp.com/nomad/acls/policies#namespace-rules
