The database secret engines generate passwords that adhere to a default pattern
that may be overridden with a new password policy. A policy defines the rules and
requirements that the password must adhere to and can provide that password
directly through a new endpoint or within secrets engines.

Login with the `admin` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=admin \
  password=admin-password
```{{execute}}

The passwords you want to generate adhere to these requirements.

- length of 20 characters
- at least 1 uppercase character
- at least 1 lowercase character
- at least 1 number
- at least 1 symbol

Define this password policy in a file named `example_policy.hcl`.

```shell
tee example_policy.hcl <<EOF
length=20

rule "charset" {
  charset = "abcdefghijklmnopqrstuvwxyz"
  min-chars = 1
}

rule "charset" {
  charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  min-chars = 1
}

rule "charset" {
  charset = "0123456789"
  min-chars = 1
}

rule "charset" {
  charset = "!@#$%^&*"
  min-chars = 1
}
EOF
```{{execute}}

The policy is written in HashiCorp Configuration Language (HCL). The `length`
field sets the length of the password returned to `20` characters. Each rule
stanza defines a character set and the minimum number of occurrences those
characters need to appear in the generated password. These rules are cumulative
so each one adds more requirements on the password generated.

Create a Vault password policy named `example` with the password policy
rules defined in `example_policy.hcl`.

```shell
vault write sys/policies/password/example policy=@example_policy.hcl
```{{execute}}

This policy can now be accessed directly to generate a password or referenced
by its name `example` when configuring supported secrets engines.

Generate a password from the `example` password policy.

```shell
vault read sys/policies/password/example/generate
```{{execute}}

The password generated adheres to the defined requirements.

### Apply the password policy

Re-configure the database secrets engine with the connection credentials for the
Postgres database.

```shell
vault write database/config/postgresql \
     plugin_name=postgresql-database-plugin \
     connection_url="postgresql://{{username}}:{{password}}@localhost:5432/postgres?sslmode=disable" \
     allowed_roles=readonly \
     username="root" \
     password="rootpassword" \
     password_policy="example"
```{{execute}}

The same connection information is used to establish the connection with the
database server. The difference is that the `password_policy` has been set to
the `example` policy.

Login with the `apps` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Read credentials from the `readonly` database role.

```shell
vault read database/creds/readonly
```{{execute}}

The credentials display the `username` and `password` generated. The `password`
generated adheres to the _example_ password policy defined in the secrets
engine's configuration.
