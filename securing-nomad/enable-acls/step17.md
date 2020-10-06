Earlier in this scenario, while boostrapping, you created a very permissive
anonymous user policy to minimize user and workload impacts from Nomad's default
deny-all policy. This allows cluster users and other submitting agents to
continue to work while tokens are being created and deployed.

As a challenge to yourself, consider the minimum viable set of permissions for
anonymous users in your organization. Craft a policy that prevents user access
to capabilities that are not in your user's critical path.
