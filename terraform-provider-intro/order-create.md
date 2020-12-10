Now that you have initialized your Terraform workspace, you will create the order using Terraform.

Add the following to your `main.tf`{{open}} file.

<pre class="file" data-filename="main.tf" data-target="append">
provider "hashicups" {
  username = "education"
  password = "test123"
}

resource "hashicups_order" "edu" {
  items {
    coffee {
      id = 3
    }
    quantity = 2
  }
  items {
    coffee {
      id = 2
    }
    quantity = 2
  }
}

output "edu_order" {
  value = hashicups_order.edu
}
</pre>

Now apply this change to create the order.

`terraform apply`{{execute T2}}

Notice how the execution plan shows a proposed order, with additional information about the order.

Remember to confirm the apply step with a `yes`{{execute T2}}.

Once the apply completes, the provider saves the resource's state. If you're running Terraform locally, your `terraform.tfstate` file contains this state. You can also view the state by running `terraform state show <resource_name>`.

Retrieve the order's state.

`terraform state show hashicups_order.edu`{{execute T2}}

### Verify order created

Verify the order was created by retrieving the order details via the API.

`curl -X GET  -H "Authorization: ${HASHICUPS_TOKEN}" localhost:19090/orders/1 | jq`{{execute T2}}

The response will look similar to the following.

```
{
  "id": 1,
  "items": [
    {
      "coffee": {
        "id": 3,
        "name": "Nomadicano",
        "teaser": "Drink one today and you will want to schedule another",
        "description": "",
        "price": 150,
        "image": "/nomad.png",
        "ingredients": null
      },
      "quantity": 2
    },
    {
      "coffee": {
        "id": 2,
        "name": "Vaulatte",
        "teaser": "Nothing gives you a safe and secure feeling like a Vaulatte",
        "description": "",
        "price": 200,
        "image": "/vault.png",
        "ingredients": null
      },
      "quantity": 2
    }
  ]
}
```

The order's properties should be the same as that of your `hashicups_order.edu` resource.