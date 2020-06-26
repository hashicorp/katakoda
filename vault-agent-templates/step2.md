
Click the **+** next to the opened Terminal, and select **Open New Terminal** to open another terminal.

![New Terminal](./assets/ops-another-terminal-2.png)

Execute the following command.

```
export VAULT_ADDR='http://127.0.0.1:8200'
vault login root
```{{execute T2}}

Let's update the `contact_email` value by executing the following command:

```
vault kv patch secret/customers/acme contact_email=jenn@acme.com
```{{execute T2}}

Check and verify the updated secrets:

```
vault kv get secret/customers/acme
```{{execute T2}}

Ensure that the `contact_email` is now set to `jenn@acme.com`

Return to the **Terminal** to view the Vault Agent log. Since the `customer.tmpl` was set to read secret with no specific secret version specified (`{{ with secret "secret/data/customers/acme" }}`), the agent will pull the latest version the next time it checks.

> **NOTE:** If you wish to always read a specific version of the `secret/customers/acme`, you can hard-set the version by setting the path to `secret/data/customers/acme?version=1`.

Wait until the agent pulls the secrets at `secret/data/customers/acme` again (~5 minutes interval):

```
...
[DEBUG] (runner) checking template 494ea5cbe4765bfe2e5eca2363eff06b
[DEBUG] (runner) rendering "./customer.tmpl" => "./customer.txt"
[INFO] (runner) rendered "./customer.tmpl" => "./customer.txt"
[DEBUG] (runner) diffing and updating dependencies
[DEBUG] (runner) vault.read(secret/data/customers/acme) is still needed
[DEBUG] (runner) watching 1 dependencies
[DEBUG] (runner) all templates rendered
...
```

First, close the opened `customer.txt` file, and then reopen `customer.txt`{{open}} to verify that the **Contact** information is now `jenn@acme.com` instead of `james@acme.com`.
