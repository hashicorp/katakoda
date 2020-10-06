Now that you’ve added create, read, update and delete capabilities to the order resource, you will build the provider and set up HashiCups to test it in the next step.

## Initialize your developer environment 

Initialize a new Go module, with this directory as its root.

`go mod init terraform-provider-hashicups`{{execute}}

Then, create a vendor directory that contains all the provider’s dependencies.

`go mod vendor`{{execute}}

## Add `order` resource to provider

Open `hashicups/provider.go`{{open}}.  Add the `order` resource to the provider's `ResourcesMap` (line 32).

<pre class="file" data-filename="hashicups/provider.go" data-target="insert" data-marker="// Add HashiCups order here">
// Add HashiCups order here
"hashicups_order": resourceOrder(),
</pre>

## Build provider

Next, run `make install` to build the binary and move your new provider into your users Terraform plugins directory. This allows you to sideload and test your custom providers.

`make install`{{execute}}

```
$ make install
go build -o terraform-provider-hashicups
mv terraform-provider-hashicups ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3/linux_amd64
```

<details style="padding-bottom: 1em;">
<summary>Error compiling provider binary</summary>
<br/>

If you get the following error: `hashicups/resource_order.go:104:10: undefined: strconv`, you need to add `"strconv"` to the top of your import statement in `hashicups/resource_order.go`{{open}}.

```
import (
  "context"
+ "strconv"

  hc "github.com/hashicorp-demoapp/hashicups-client-go"
  "github.com/hashicorp/terraform-plugin-sdk/v2/diag"
  "github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)
```

</details>

## Deploy HashiCups locally (in Katacoda)

You will need the HashiCups API running locally (in Katacoda) to test your HashiCups provider.

Navigate to `docker_compose` and initialize the application.

`cd docker_compose && docker-compose up`{{execute}}

### Verify HashiCups API is running

When the HashiCups API is running, you will see log messages in your terminal window.

Once you see the following message in the HashiCups logs, verify that HashiCups is running.

```
api_1  | 2020-10-12T07:34:02.377Z [INFO]  Starting service: bind=0.0.0.0:9090 metrics=localhost:9102
```

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

Set the `HASHICUPS_TOKEN` environment variable to the token you retrieved from invoking the `/signin` endpoint. You will use this later in the tutorial to verify your HashiCups order has been created, updated and deleted.

`export HASHICUPS_TOKEN=$(curl -X POST localhost:19090/signin -d '{"username":"education", "password":"test123"}' | jq --raw-output '.token')`{{execute T2}}