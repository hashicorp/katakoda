Change your order by updating the order resource through Terraform. In your `main.tf`, update the coffee quantity in `hashicups_order.edu` block.

Change the first coffee item from `2` to `3` and change the second coffee item from `2` to `1`.

```
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
```

Run `terraform apply` to update the order. Notice how the execution plan reflects the order change. Terraform is able to determine that these changes could be done in place rather than destroying the current order and creating a new one. This is because the modified property ([quantity](https://github.com/hashicorp/terraform-provider-hashicups/blob/master/hashicups/resource_order.go#L63)) does not have `ForceNew` set to `true`. When `ForceNew` is set to `true`, it will destroy the existing instance and provision a instance with the updated attributes. An example of this is when you change an [AWS EC2 instance's AMI](https://github.com/terraform-providers/terraform-provider-aws/blob/a15140e1184d201c9cf4cfe46f154a48c4a08958/aws/resource_aws_instance.go#L45-L49).

`terraform apply`{{execute T2}}

Remember to confirm the apply step with a `yes`{{execute T2}}.

Once the apply completes, view the output. Notice that while the `order_id` remained the same (`1`), the provider updated the order's coffee quantity and assigned the current time to the newly created `last_updated` field.

```
Outputs:

edu_order = {
  "id" = "1"
  "items" = [
    {
      "coffee" = [
        {
          "description" = ""
          "id" = 3
          "image" = "/nomad.png"
          "name" = "Nomadicano"
          "price" = 150
          "teaser" = "Drink one today and you will want to schedule another"
        },
      ]
      "quantity" = 3
    },
    {
      "coffee" = [
        {
          "description" = ""
          "id" = 2
          "image" = "/vault.png"
          "name" = "Vaulatte"
          "price" = 200
          "teaser" = "Nothing gives you a safe and secure feeling like a Vaulatte"
        },
      ]
      "quantity" = 1
    },
  ]
  "last_updated" = "Thursday, 16-Jul-20 04:13:48 PDT"
}
```

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

The order's properties should be the same as that of your updated `hashicups_order.edu` resource. There should be `3` Nomadicano and `1` Vaulatte.