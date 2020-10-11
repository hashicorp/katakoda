Now that you’ve built your Terraform provider and set up the HashiCups API, you will use Terraform to create, update and delete a HashiCups resource to verify that your provider works.

Navigate to the `examples` directory. This contains a sample Terraform configuration for the Terraform HashiCups provider.

`cd ~/terraform-provider-hashicups/examples/`{{execute T2}}

Initialize your Terraform workspace. Terraform will find the provider that you installed into `~/.terraform.d/plugins` with the `make install` command in the previous step.

`terraform init`{{execute T2}}

### Create order

Now that you have initialized your Terraform workspace, create an order using the provider. The `order.tf`{{open}} file will already contain an example configuration to create a new order.

`terraform apply`{{execute T2}}

Notice how the execution plan shows a proposed order, with additional information about the order.

Remember to confirm the apply step with a `yes`.

Once the apply completes, the provider saves the resource's state. When you run Terraform locally, the `terraform.tfstate` file contains this state. You can also view the state by running `terraform state show <resource_name>`.

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

The order's properties will be the same as those of your `hashicups_order.edu` resource.

## Update order

Change your order by updating the order resource through Terraform. 

Open your `examples/order.tf`{{open}}, update the coffee quantity in `hashicups_order.edu` block.

Change the first coffee item from `2` to `3` and change the second coffee item from `2` to `1`.

<pre class="file" data-filename="examples/order.tf" data-target="replace">
resource "hashicups_order" "edu" {
  items {
    coffee {
      id = 3
    }
    quantity = 3
  }
  items {
    coffee {
      id = 2
    }
    quantity = 1
  }
}

output "edu_order" {
  value = hashicups_order.edu
}
</pre>

Run `terraform apply` to update the order. 

`terraform apply`{{execute T2}}

Remember to confirm the apply step with a `yes`.

Once the apply completes, view the output. Notice that while the `order_id` remained the same (`1`), the provider updated the order's coffee quantity.

### Verify order updated

Verify the order was updated by retrieving the order details via the API.

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
      "quantity": 3
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
      "quantity": 1
    }
  ]
}
```

The order's properties will be the same as that of your updated `hashicups_order.edu` resource. There will be `3` Nomadicano and `1` Vaulatte.

## Delete order

Finally, you can delete resources in Terraform. Run `terraform destroy`. 

`terraform destroy`{{execute T2}}

Remember to confirm the apply step with a `yes`.

When the destroy step completes, the provider has destroyed the order resource, reflected by an empty state file.

### Verify order deleted

Verify the order was deleted by retrieving the order details via the API. 

`curl -X GET  -H "Authorization: ${HASHICUPS_TOKEN}" localhost:19090/orders/1 | jq`{{execute T2}}

The response will look similar to the following.

```
{}
```

The order is blank, as expected.