In this step, you will add update capabilities to the `order` resource.

If you’re stuck, refer to the complete update function at the end of this step to see the changes implemented in this step.

The update function:
1. retrieves API Client from meta parameter
1. retrieves order ID
1. maps the order `schema.Resource` to `[]hc.OrderItems{}` **if changes to "items" are detected**
1. invokes the `UpdateOrder` function on the HashiCups client
1. maps response (hc.Order) to order schema.Resource (similar to resourceOrderRead)

## Define `resourceOrderUpdate` function

The update function is similar to the create function. First, it retrieves the authenticated API client.

```
c := m.(*hc.Client)
```

Then, the function retrieves the order ID. This is because the `UpdateOrder` function requires both the orderID and a list of updated order items.

```
orderID := d.Id()
```

Two keys difference between the update function and the create function is:
1. the update function checks to see if the schema has changed before proceeding; the create function does not
1. the create function sets the resourceID; in most many cases, the update function **should not**

```
if d.HasChange("items") {}
```

If the `"items"` schema has changed, you should map the schema to a `[]hc.OrderItem{}`, a list of order items that the `UpdateOrder` function takes as an argument. Else, you should invoke the `resourceOrderRead` function to update the schema so it reflects the resource's current state.

## Map the order `schema.Resource` to `[]hc.OrderItems{}`

Add the following code snippet to the `resourceOrderUpdate` function in `hashicups/resource_order.go`{{open}}. This should be triggered whenever the `"items"` schema changes.

This is similar to how the schema was mapped in the create function.

```
items := d.Get("items").([]interface{})
ois := []hc.OrderItem{}

for _, item := range items {
  i := item.(map[string]interface{})

  co := i["coffee"].([]interface{})[0]
  coffee := co.(map[string]interface{})

  oi := hc.OrderItem{
    Coffee: hc.Coffee{
      ID: coffee["id"].(int),
    },
    Quantity: i["quantity"].(int),
  }
  ois = append(ois, oi)
}
```


## Invoke UpdateOrder function

Next, invoke the `UpdateOrder` function with the order ID and `ois`, the mapped `[]hc.OrderItems{}`, as arguments.

If the `UpdateOrder` function fails, return the error.

```
_, err := c.UpdateOrder(orderID, ois)
if err != nil {
  return diag.FromErr(err)
}
```

Notice how the `UpdateOrder` response is disregarded, even though it returns the updated order information. The UpdateOrder function ends by invoking the read function, `resourceOrderRead(ctx, d, m)`. This verifies that the schema reflects the API's current state, and maps the response to the order `schema.Resource`.

<details style="padding-bottom: 1em;">
<summary>Complete update function</summary>
<br/>
Replace the `resourceOrderUpdate` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This function will update the order resource if there are any changes to the order items.

```
func resourceOrderUpdate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
  c := m.(*hc.Client)

  orderID := d.Id()

  if d.HasChange("items") {
    items := d.Get("items").([]interface{})
    ois := []hc.OrderItem{}

    for _, item := range items {
      i := item.(map[string]interface{})

      co := i["coffee"].([]interface{})[0]
      coffee := co.(map[string]interface{})

      oi := hc.OrderItem{
        Coffee: hc.Coffee{
          ID: coffee["id"].(int),
        },
        Quantity: i["quantity"].(int),
      }
      ois = append(ois, oi)
    }

    _, err := c.UpdateOrder(orderID, ois)
    if err != nil {
      return diag.FromErr(err)
    }
  }

  return resourceOrderRead(ctx, d, m)
}
```

The function determines whether there are discrepancies in the `items` property between the configuration and the state.

If there are discrepancies, the function will update the order with the new configuration. Finally, it will call `resourceOrderRead` to update the resource's state.
