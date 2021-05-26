Now that you have implemented the create functionality, you must implement read to retrieve the resource current state. Terraform will run this function during the `plan` process to determine whether the resource needs to be updated.

The `resourceOrderRead` function:
1. retrieves HashiCups API Client from meta parameter
1. retrieves order ID
1. invokes the `GetOrder` function on the HashiCups client
1. maps response (`hc.Order`) to order `schema.Resource`

Since `hc.Order` is a nested object, you will use flattening functions to map `hc.Order` to the Terraform order schema.

The read function is named `resourceOrderRead` and starts on line 116 in `hashicups/resource_order.go`{{open}}. `resourceOrderRead` has already been implemented for you. You will define one of the flattening functions in this step.

## Explore the `resourceOrderRead` function

First, the read function retrieves the authenticated HashiCups API client from the meta parameter (line 118).

```
c := m.(*hc.Client)
```

Then, the read function retrieves the resource ID using `d.Id()`.

```
orderID := d.Id()
```

The read function uses this value as an argument in `GetOrder` to retrieve the order's information. If `GetOrder` fails, the provider will error with the HashiCups API Client's API error message.

```
order, err := c.GetOrder(orderID)
if err != nil {
  return diag.FromErr(err)
}
```

Finally, flattening functions are used to map the response (`hc.Order`) to order `schema.Resource`.

```
orderItems := flattenOrderItems(&order.Items)
if err := d.Set("items", orderItems); err != nil {
  return diag.FromErr(err)
}
```

## Explore flattening functions

The HashiCups API Client's `GetOrder` function returns an order object that needs to be "flattened" so the provider can accurately map it to the order `schema`. An order consists of an order ID and a list of coffee objects and their respective quantities.

As a result, it must go through two flattening functions:

1. The first flattening function, `flattenOrderItems`, populates the list of coffee objects and their quantities
1. **The second flattening function, `flattenCoffee`, populates the actual coffee object itself.**

The first flattening function has been implemented for you. You will implement `flattenCoffee`, the second flattening function.

### Explore the `flattenOrderItems` function 

You can find the  `flattenOrderItems` function on line 190 of the `hashicups/resource_order.go`{{open}} file.

This function takes a list of OrderItems (`*[]hc.OrderItem`) from the HashiCups API Client and returns a flattened list of order items in the same structure as defined in the resourceOrder schema (`[]interface{}`).

```
func flattenOrderItems(orderItems *[]hc.OrderItem) []interface{} {
	if orderItems != nil {
		ois := make([]interface{}, len(*orderItems), len(*orderItems))

		for i, orderItem := range *orderItems {
			oi := make(map[string]interface{})

			oi["coffee"] = flattenCoffee(orderItem.Coffee)
			oi["quantity"] = orderItem.Quantity

			ois[i] = oi
		}

		return ois
	}

	return make([]interface{}, 0)
}
```

### Implement the `flattenCoffee` function 

The second flattening function, `flattenCoffee`, is declared on line 214 of the `hashicups/resource_order.go`{{open}} file.

The `flattenCoffee` function is called in the first flattening function. This function takes a coffee (`hc.Coffee`) and turns returns a flattened list of coffee attributes (`[]interface{}{c}`). Notice how this mirrors the coffee schema — a `schema.TypeList` with a maximum of one item.

> Interactive Code Portion

Map the `coffee` `hc.Coffee` input type to the `c` interface type.

The coffee object has the following attributes: `ID`, `Name`, `Teaser`, `Description`, `Price` and `Image`.

<details style="padding-bottom: 1em;">
<summary>Hint</summary>

Add the following code snippet to line 217. This maps `coffee` to the `c` interface type.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker="// ** | Map Coffee attributes">
```
// ** | Map Coffee attributes
c["id"] = coffee.ID
c["name"] = coffee.Name
c["teaser"] = coffee.Teaser
c["description"] = coffee.Description
c["price"] = coffee.Price
c["image"] = coffee.Image
```
</pre>
</details>

To format your code, run `go fmt ./...`{{execute}} then close and reopen your file (`hashicups/resource_order.go`{{open}}). This allows KataCoda to refresh your file in the editor.

## Next steps

You have implemented the read function and both flattening functions. This enables the provider to retrieve the order resource's current state.

In the next step, you will implement the update function.