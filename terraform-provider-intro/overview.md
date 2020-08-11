In this scenario, you use a Terraform provider to interact with a fictional coffee-shop application, HashiCups, by completing the following actions:

1. Initialize Terraform Workspace
1. Create a HashiCups order
1. Update a HashiCups order
1. Read coffee ingredients (data source)
1. Delete a HashiCups order

This scenario includes a pre-installed Terraform 0.13, a pre-installed Terraform HashiCups provider and an instance of the HashiCups API running.

### Verify HashiCups API is running

Once you see the HashiCups logs running in your terminal, verify that HashiCups is running.

Click on the following command to send a request to HashiCup's health check endpoint in another terminal.

`curl localhost:19090/health`{{execute T2}} 

### Create HashiCups user

Create a user on HashiCups named `education` with the password `test123`.

`curl -X POST localhost:19090/signup -d '{"username":"education", "password":"test123"}'`{{execute T2}}

This will return the userID, username, and a JWT token. Your JWT authorization token will be used later to retrieve your orders.

```
{"UserID":1,"Username":"education","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTEwNzgwODUsInVzZXJfaWQiOjIsInVzZXJuYW1lIjoiZWR1Y2F0aW9uIn0.CguceCNILKdjOQ7Gx0u4UAMlOTaH3Dw-fsll2iXDrYU"}
```

Set `HASHICUPS_TOKEN` to the token you retrieved from invoking the `/signup` endpoint. You will use this later in the tutorial to verify your HashiCups order has been created, updated and deleted.

`export HASHICUPS_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....`{{execute T2}}

The terminal containing your HashiCups logs will have recorded both operations.

```
api_1  | 2020-07-16T09:19:50.601Z [INFO]  Handle User | signup
api_1  | 2020-07-16T09:19:59.601Z [INFO]  Handle User | signin
```

Now that the HashiCups app is running, you're ready to interact with it using the Terraform provider.

### Initialize Terraform workspace

Now that the HashiCups API is running, navigate to the `learn-terraform-hashicups-provider` directory before initializing your Terraform workspace.

`cd learn-terraform-hashicups-provider`{{execute T2}}

`terraform init`{{execute T2}}

This downloads all providers listed in the `required_providers` argument in `main.tf`{{open}}. The HashiCups provider has already been downloaded and installed in its respective directory: `~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.2/linux_amd64`