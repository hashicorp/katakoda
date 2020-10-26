First, login with root token.

```
vault login root
```{{execute T1}}

Write some secrets at `secret` paths. The test data is provided in the `data.json`{{open}} file.

```
{
  "organization": "ACME Inc.",
  "customer_id": "ABXX2398YZPIE7391",
  "region": "US-West",
  "zip_code": "94105",
  "type": "premium",
  "contact_email": "james@acme.com",
  "status": "active"
}
```

Execute the following commands to write the data:

```
vault kv put secret/customers/acme @data.json
```{{execute T1}}

Check to verify the secrets at `secret/customers/acme`:

```
vault kv get secret/customers/acme
```{{execute T1}}

<br />

## Setup Auth Method

Setup the auth method on the Vault server. In this example, you are going to enable [`approle`](https://www.vaultproject.io/docs/auth/approle.html) auth method.

```
vault auth enable approle
```{{execute T1}}

Create a policy named, "app-pol" which is defined by the `app-pol.hcl`{{open}} file.

```
vault policy write app-pol app-pol.hcl
```{{execute T1}}

Execute the following command to create a role named, "apps" with `app-pol` policy attached.

```
vault write auth/approle/role/apps policies="app-pol"
```{{execute T1}}

Now, generate a role ID and stores it in a file named, "roleID".

```
vault read -format=json auth/approle/role/apps/role-id \
        | jq  -r '.data.role_id' > roleID
```{{execute T1}}

The `approle` auth method allows machines or apps to authenticate with Vault using Vault-defined roles. The generated `roleID`{{open}} is equivalent to a username.

Also, generate a secret ID and stores it in the "secretID" file.

```
vault write -f -format=json auth/approle/role/apps/secret-id \
        | jq -r '.data.secret_id' > secretID
```{{execute T1}}

<br />

## Vault Agent Configuration

Vault Agent runs on the **client** side to automate leases and tokens lifecycle management.

Examine the Vault Agent configuration file, `agent-config.hcl`{{open}}.

```
pid_file = "./pidfile"

vault {
   address = "http://127.0.0.1:8200"
}

auto_auth {
   method "approle" {
       mount_path = "auth/approle"
       config = {
           role_id_file_path = "roleID"
           secret_id_file_path = "secretID"
           remove_secret_id_file_after_reading = false
       }
   }

   sink "file" {
       config = {
           path = "approleToken"
       }
   }
}

template {
  source      = "./customer.tmpl"
  destination = "./customer.txt"
}
```

> Notice the **`template`** block. This defines the path on disk to use as the input template which uses Consul Templates markup.  The `destination` specifies the desired rendered output file.

View the `customer.tmpl`{{open}} file.


Execute the following command to start the Vault Agent with `debug` logs.

```
vault agent -config=agent-config.hcl -log-level=debug
```{{execute T1}}

The agent log should include the following messages:

```
...
[DEBUG] (runner) checking template c6c6b1e5bb647223b68c4e2f66b9f182
[DEBUG] (runner) rendering "./customer.tmpl" => "./customer.txt"
[INFO]  (runner) rendered "./customer.tmpl" => "./customer.txt"
[DEBUG] (runner) diffing and updating dependencies
[DEBUG] (runner) vault.read(secret/data/customers/acme) is still needed
[DEBUG] (runner) watching 1 dependencies
[DEBUG] (runner) all templates rendered
...
```

Vault Agent read the secrets at `secret/customer/acme` based on the `customer.tmpl` file and outputed the rendered data into the `customer.txt`{{open}} file.

```
Organization: ACME Inc.
ID: ABXX2398YZPIE7391
Contact: james@acme.com
```
