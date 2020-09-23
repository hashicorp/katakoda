Now that you’ve added create, read, update and delete capabilities to the order resource, you will build the provider and set up HashiCups to test it in the next step.

## Build provider

First, you will need to build the binary and move it into your user Terraform plugins directory. This allows you to sideload and test your custom providers.

The `make install` command automates these two steps.

`make install`{{execute}}

```
$ make install
go build -o terraform-provider-hashicups
mv terraform-provider-hashicups ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3/linux_amd64
```

## Deploy HashiCups locally

You will need HashiCups running locally to test your HashiCups provider.

Navigate to `docker_compose` and initialize the application.

`cd docker_compose && docker-compose up`{{execute}}

### Verify HashiCups API is running

Once you see the HashiCups logs running in the KataCoda terminal window, verify that HashiCups is running.

Click on the following command to send a request to HashiCup's health check endpoint in another terminal.

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