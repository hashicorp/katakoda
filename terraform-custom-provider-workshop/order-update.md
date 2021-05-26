In this step, you will add update capabilities to the `order` resource.

> If you get stuck, refer to the complete update function at the end of this step to see the changes implemented in this step.

The update function:
1. retrieves HashiCups API Client from meta parameter
1. retrieves order ID
1. **maps the order `schema.Resource` to `[]hc.OrderItems{}` if changes to "items" are detected**
1. invokes the `UpdateOrder` function on the HashiCups client
1. maps response (hc.Order) to order schema.Resource (similar to resourceOrderRead)

The update function is named `resourceOrderUpdate` and starts on line 141 in `hashicups/resource_order.go`{{open}}. Most of these steps have been implemented, you will only map the order `schema.Resource` to `[]hc.OrderItems{}`.

## Explore the `resourceOrderUpdate` function

First, the update function retrieves the authenticated HashiCups API client.

```
c := m.(*hc.Client)
```

Next, the function retrieves the order ID. This is because the `UpdateOrder` function requires both the orderID and a list of updated order items.

```
orderID := d.Id()
```

Two keys differences between the update function and the create function are:
1. the update function checks to see if the schema has changed before proceeding; the create function does not
1. the create function sets the resourceID; in most cases, the update function **should not**

```
if d.HasChange("items") {}
```

If the `"items"` schema has changed, the update function should map the schema to a `[]hc.OrderItem{}`, a list of order items that the `UpdateOrder` function takes as an argument. Otherwise, the update function should invoke the `resourceOrderRead` function to update the schema so it reflects the resource's current state.

## Map the order `schema.Resource` to `[]hc.OrderItems{}`

If the `"items"` schema has changed, the update function retrieves the new schema.

```
if d.HasChange("items") {
  items := d.Get("items").([]interface{})
  
  ...
}
```

> Interactive Code Portion

Add the following code to the `resourceOrderUpdate` function inside the if statement (line 153). This loops through the order items defined in the schema and maps it to a `[]hc.OrderItems{}` type.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker="// ** | Map the order schema.Resource to []hc.OrderItems{}">
// ** | Map the order schema.Resource to []hc.OrderItems{}
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
</pre>

To format your code, run `go fmt ./...`{{execute}} then close and reopen your file (`hashicups/resource_order.go`{{open}}). This allows KataCoda to refresh your file in the editor.

## Invoke `UpdateOrder` function

Next, the update function invokes the `UpdateOrder` function with the order ID and `ois`, the mapped `[]hc.OrderItems{}`, as arguments. If the `UpdateOrder` function fails, the update function returns the error.

This can be found on line 170.

```
_, err := c.UpdateOrder(orderID, ois)
if err != nil {
  return diag.FromErr(err)
}
```

The `UpdateOrder` response is not used here because the function uses the `resourceOrderRead` function to verify that the schema and the current API state map to the order `schema.Resource`.

## Next steps

You have implemented the update function. 

In the next step, you implement the delete function.

You can view the complete update function below to confirm your work.

<details style="padding-bottom: 1em;">
<summary>Complete update function</summary>
<br/>
Replace the `resourceOrderUpdate` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This function will update the order resource if there are any changes to the order items.

<pre class="file" data-target="clipboard">
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
</pre>

The function determines whether there are discrepancies in the `items` property between the configuration and the state.

If there are discrepancies, the function will update the order with the new configuration. Finally, it will call `resourceOrderRead` to update the resource's state.
