The ACL system is designed to be intuitive, high-performance, and to provide
administrative insight. At the highest level, there are four core objects used
in the ACL system.

- Tokens
- Policies
    - Rules
- Capabilities

## Core objects overview

- **Tokens** - Requests to Nomad are authenticated using a bearer token.
  Each ACL token has a public Accessor ID which is used to name a token and a
  Secret ID which is used to make requests to Nomad. The Secret ID is provided
  using a request header (`X-Nomad-Token`) and is used to authenticate the
  caller. Tokens are either `management` or `client` types. The `management`
  tokens are effectively "root" in the system and can perform any operation.
  The `client` tokens are associated with one or more ACL policies which grant
  specific capabilities.

- **Policies** - Policies consist of a set of rules defining the capabilities or
  actions to be granted. For example, a "readonly" policy might only grant the
  ability to list and inspect running jobs, but not to submit new ones. No
  permissions are granted by default, making Nomad a default-deny system.

  - **Rules** - Policies are comprised of one or more rules. The rules define
    the capabilities of a Nomad ACL token for accessing objects in a Nomad
    cluster—like namespaces, node, agent, operator, quota. The
    full set of rules are discussed in a later section.

- **Capabilities** - Capabilities are the set of actions that can be performed.
  This includes listing jobs, submitting jobs, querying nodes, etc. A
  `management` token is granted all capabilities, while `client` tokens are
  granted specific capabilities via ACL policies. The full set of capabilities
  is discussed in the rule specifications.
