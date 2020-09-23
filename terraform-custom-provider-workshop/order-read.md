Now that you have implemented create, you must implement read to retrieve the resource current state. This will be run during the `plan` process to determine whether the resource needs to be updated.

The read function:
1. retrieves API Client from meta parameter
1. retrieves order ID
1. invokes the GetOrder function on the HashiCups client
1. maps response (`hc.Order`) to order `schema.Resource`

Since `hc.Order` is a nested object, you will use flattening functions to map `hc.Order` to the Terraform order schema.

## Define `resourceOrderRead` function

Replace the `resourceOrderRead` function in `hashicups/resource_order.go`{{open}} with the following code snippet.

Notice how the function retrieves the resource ID using `d.Id()`. It uses this value as an argument in `GetOrder` to retrieve the order's information. Next, flattening functions are used to map the response (`hc.Order`) to order `schema.Resource`.

```
func resourceOrderRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
  // 1. Retrieve API client from meta parameter
  c := m.(*hc.Client)

  // Warning or errors can be collected in a slice type
  var diags diag.Diagnostics
  
  // 2. Retrieve order ID
  orderID := d.Id()
  
  // 3. Invoke the GetOrder function on the HashiCups client
  order, err := c.GetOrder(orderID)
  if err != nil {
    return diag.FromErr(err)
  }
  
  // 4. Maps response (hc.Order) to order schema.Resource through flattening functions
  orderItems := flattenOrderItems(&order.Items)
  if err := d.Set("items", orderItems); err != nil {
    return diag.FromErr(err)
  }

  return diags
}
```

## Define flattening functions

The API Client's `GetOrder` function returns an order object that needs to be "flattened" so the provider can accurately map it to the order `schema`. An order consists of an order ID and a list of coffee objects and their respective quantities.

As a result, it must go through two flattening functions:

1. The first flattening function populates the list of coffee objects and their quantities
1. The second flattening function populates the actual coffee object itself.

### First flattening function 

Replace the `flattenOrderItems` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This is the first flattening function to return a list of order items. The `flattenOrderItems` function takes an `*[]hc.OrderItem` as `orderItems`. If `orderItems` is not `nil`, it will iterate through the slice and map its values into a `map[string]interface{}`.

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

### Second flattening function 

Replace the `flattenCoffee` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This is called in the first flattening function. It takes a `hc.Coffee` and turns a slice with a single object. Notice how this mirrors the coffee schema — a `schema.TypeList` with a maximum of one item.

```
func flattenCoffee(coffee hc.Coffee) []interface{} {
  c := make(map[string]interface{})
  c["id"] = coffee.ID
  c["name"] = coffee.Name
  c["teaser"] = coffee.Teaser
  c["description"] = coffee.Description
  c["price"] = coffee.Price
  c["image"] = coffee.Image

  return []interface{}{c}
}
```

Now that you've implemented both flattening functions, you have implemented read to retrieve the resource current state.