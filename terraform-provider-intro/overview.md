In this scenario, you will use a Terraform provider to interact with a fictional coffee-shop application, HashiCups, by completing the following actions:

1. Initialize Terraform Workspace
1. Create a HashiCups order
1. Update a HashiCups order
1. Read coffee ingredients (data source)
1. Delete a HashiCups order

This scenario includes a pre-installed Terraform 0.14, a pre-installed Terraform HashiCups provider and an instance of the HashiCups API running locally.

Do not stop the HashiCups API running in the first terminal. You will reference these logs to verify the endpoints the HashiCups provider calls.

### Verify HashiCups API is running

Once you see the HashiCups logs running in the KataCoda terminal window, verify that HashiCups is running.

Click on the following command to send a request to HashiCup's health check endpoint in another terminal

`curl localhost:19090/health`{{execute T2}} 

You will see `ok` appear in the `Terminal 2` tab in response to the health check

### Create HashiCups user

Use the demo HashiCups API to create a user on HashiCups named `education` with the password `test123`.

`curl -X POST localhost:19090/signup -d '{"username":"education", "password":"test123"}' | jq`{{execute T2}}

The response will look similar to the following.

```
{
  "UserID": 1,
  "Username": "education",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTEwNzgwODUsInVzZXJfaWQiOjIsInVzZXJuYW1lIjoiZWR1Y2F0aW9uIn0.CguceCNILKdjOQ7Gx0u4UAMlOTaH3Dw-fsll2iXDrYU"
}
```

Then, authenticate to HashiCups. This will return the userID, username, and a JSON Web Token (JWT) authorization token. You will use the JWT authorization token later to retrieve your orders.

`curl -X POST localhost:19090/signin -d '{"username":"education", "password":"test123"}' | jq`{{execute T2}}

The response will look similar to the following.

```
{
  "UserID": 1,
  "Username": "education",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTEwNzgwODUsInVzZXJfaWQiOjIsInVzZXJuYW1lIjoiZWR1Y2F0aW9uIn0.CguceCNILKdjOQ7Gx0u4UAMlOTaH3Dw-fsll2iXDrYU"
}
```

Set `HASHICUPS_TOKEN` to the token you retrieved from invoking the `/signin` endpoint. You will use this later in the tutorial to verify your HashiCups order has been created, updated and deleted.

`export HASHICUPS_TOKEN=$(curl -X POST localhost:19090/signin -d '{"username":"education", "password":"test123"}' | jq --raw-output '.token')`{{execute T2}}

The terminal containing your HashiCups logs will have recorded the signup and signin operations.

```
api_1  | 2020-07-16T09:19:50.601Z [INFO]  Handle User | signup
api_1  | 2020-07-16T09:19:59.601Z [INFO]  Handle User | signin
api_1  | 2020-07-16T09:20:21.601Z [INFO]  Handle User | signin
```

Now that you have created a HashiCups user, you're ready to use the Terraform provider to interact with the API.

### Initialize Terraform workspace

Navigate to the `learn-terraform-hashicups-provider` directory and initialize your Terraform workspace.

`cd learn-terraform-hashicups-provider`{{execute T2}}

`terraform init`{{execute T2}}

This downloads all providers listed in the `required_providers` argument in `main.tf`{{open}}. This lab's initialization script downloaded the HashiCups provider installed to the following directory: `~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/linux_amd64`