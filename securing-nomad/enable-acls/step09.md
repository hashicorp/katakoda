ACL policies are written using [HashiCorp Configuration Language (HCL)][HCL].
This language is designed for human readability. The HCL interpreter also parses
JSON which facilitates the use of machine-generated configuration.

An ACL policy contains one or more rules. Rules contain coarse-grained policy
dispositions. Rules typically have several policy dispositions:

- `read`: allow the resource to be read but not modified

- `write`: allow the resource to be read and modified

- `deny`: do not allow the resource to be read or modified. Deny takes
  precedence when multiple policies are associated with a token.

- `list`: allow the resource to be listed but not inspected in
  detail. Applies only to plugins.

Some rules, such as namespace and host_volume, also allow the policy designer to
specify a policy in terms of a coarse-grained policy disposition, fine-grained
capabilities, or a combination of the two.

You can read a more comprehensive treatment of this topic in the
[Nomad ACL Policy Concepts] HashiCorp Learn Guide. Take some time to review that
guide now.

[HCL]: https://github.com/hashicorp/hcl/
[Nomad ACL Policy Concepts]: https://learn.hashicorp.com/nomad/acls/policies