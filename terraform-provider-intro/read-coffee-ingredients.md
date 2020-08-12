Add a data block to retrieve ingredients for the first coffee from your order. A data block retrieves additional information about a resource, which allows you to reference it in another Terraform resource. In this example, you will use it in an `output` block to display the coffee ingredients.
 
Add the following to your `main.tf`{{open}} file.

<pre class="file" data-filename="main.tf" data-target="append">
data "hashicups_ingredients" "first_coffee" {
  coffee_id = hashicups_order.edu.items[0].coffee[0].id
}

output "first_coffee_ingredients" {
  value = data.hashicups_ingredients.first_coffee
}
</pre>

Now apply this change to create the order.

`terraform apply`{{execute T2}}

Notice how the execution plan shows a proposed order, with additional information about the order.

Remember to confirm the apply step with a `yes`{{execute T2}}.

Once the apply completes, you should see something similar to the following.

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

first_coffee_ingredients = {
  "coffee_id" = 3
  "id" = "3"
  "ingredients" = [
    {
      "id" = 1
      "name" = "ingredient - Espresso"
      "quantity" = 20
      "unit" = "ml"
    },
    {
      "id" = 3
      "name" = "ingredient - Hot Water"
      "quantity" = 100
      "unit" = "ml"
    },
  ]
}
```

As you can see, ingredients of a Nomadicano is 20 ml espresso and 100 ml hot water.