In this step, you will add delete capabilities to the order resource.

The delete function:
1. retrieves HashiCups API Client from meta parameter
1. retrieves order ID
1. invokes the DeleteOrder function on the HashiCups client

The delete function retrieves the order ID using `d.ID()` and deletes the order.

The delete function is named `resourceOrderDelete` and starts on line 181 in `hashicups/resource_order.go`{{open}}. This function has been implemented for you.

## Explore the `resourceOrderDelete` function

First, the delete function retrieves the authenticated HashiCups API client.

```
c := m.(*hc.Client)
```


Then, the delete function retrieves the resource ID using `d.Id()`.

```
orderID := d.Id()
```

The delete function uses this value as an argument in `DeleteOrder` to retrieve the order's information. If `DeleteOrder` fails, the provider will error with the HashiCups API Client's API error message.

```
err := c.DeleteOrder(orderID)
if err != nil {
  return diag.FromErr(err)
}
```


If the delete function returns: 
- **without** an error, the provider assumes the resource is destroyed and all state is removed.
- **with** an error, the provider assumes the resource still exists and all prior state is preserved.

The delete function should never update any state on the resource. 

In addition, the delete callback should always handle the case where the resource might already be destroyed.

If the resource is already destroyed, the delete function should not return an error. If the target API doesn't have this functionality, the delete function should verify the resource exists; if the resource does not exist, set the resource ID to `""`. This behavior allows Terraform users to manually delete resources without breaking Terraform.

## Next steps

You have explored the delete function which enables the provider to delete the order.

In the next step, you will build the provider and start the HashiCups API.