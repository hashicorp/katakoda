In this step, you will add delete capabilities to the order resource.

The delete function:
1. retrieves API Client from meta parameter
1. retrieves order ID
1. invokes the DeleteOrder function on the HashiCups client

The destroy function retrieves the order ID using `d.ID()` and deletes the order.

- If the destroy function returns **without** an error, the provider assumes the resource is destroyed and all state is removed.
- If the destroy function returns **with** an error, the provider assumes the resource still exists and all prior state is preserved.

The destroy function should never update any state on the resource. In addition, the destroy callback should always handle the case where the resource might already be destroyed. If the resource is already destroyed, the destroy function should not return an error. If the target API doesn't have this functionality, the destroy function should verify the resource exists; if the resource does not exist, set the resource ID to "". This behavior allows Terraform users to manually delete resources without breaking Terraform.

Replace the `resourceOrderDelete` function in `hashicups/resource_order.go`{{open}} with the code snippet below. This function will delete the HashiCups order and Terraform resource.

<pre>
func resourceOrderDelete(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
  c := m.(*hc.Client)

  // Warning or errors can be collected in a slice type
  var diags diag.Diagnostics

  orderID := d.Id()

  err := c.DeleteOrder(orderID)
  if err != nil {
    return diag.FromErr(err)
  }

  return diags
}
</pre>