Now that you have defined the `order` resource schema, you will define the `resourceOrderCreate` function.

> If you’re stuck, refer to the complete create function at the end of this step to see the changes implemented in this step.

The create function:
1. retrieves API Client from meta parameter
1. maps the order `schema.Resource` to `[]hc.OrderItems{}`
1. invokes the CreateOrder function on the HashiCups client
1. **set order ID as resource ID**
1. maps response (`hc.Order`) to order `schema.Resource` (similar to `resourceOrderRead`)

The create function is named `resourceOrderCreate` and starts on line 71. Most of these steps have been implemented, you will only set the order ID as the resource ID.

## Explore `resourceOrderCreate` function

The create function uses the HashiCups API client to create a new order.

On line 73, the function first retrieves the API client from the meta parameter.

```
c := m.(*hc.Client)
```

Then, the function retrieves the `OrderItems` from the schema's `items` (line 79). 

```
items := d.Get("items").([]interface{})
```

It map these properties into `[]hc.OrderItem{}` which will be used to invoke the API client's `CreateOrder` function. Notice how each coffee object (`co`) is the first element of a `[]interface{}`. This is because coffee is represented as a `schema.TypeList` of one object in the schema.

```
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

Next, the create function invokes the `CreateOrder` function with `ois`, the mapped `[]hc.OrderItems{}`, as an argument (line 99).

If the `CreateOrder` function fails, return the error.

```
o, err := c.CreateOrder(ois)
if err != nil {
  return diag.FromErr(err)
}
```

## Set order ID as resource ID

Next, use `SetID` to set the resource ID to the order ID. The resource ID must be a non-blank string that can be used to read the resource again. If no ID is set, Terraform assumes the resource was not created successfully; as a result, no state will be saved for that resource.

Because order ID is returned as an integer, you must convert it to a string before setting it as your resource ID.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker="// ** | Set order ID as resource ID">
// ** | Set order ID as resource ID
d.SetId(strconv.Itoa(o.ID))
</pre>

## Add dependencies

Since the `resourceOrderCreate` function uses `strconv` to convert the ID into a string, remember to import the `strconv` library. Remember to also import the HashiCups API client library.

```
import (
  "context"
+ "strconv"

  hc "github.com/hashicorp-demoapp/hashicups-client-go"
  "github.com/hashicorp/terraform-plugin-sdk/v2/diag"
  "github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)
```

## Next steps

You have implemented the create function. 

In the next step, you implement the read function.

You can view the complete create function below to confirm your work.

<details style="padding-bottom: 1em;">
<summary>Complete create function</summary>
<br/>
Replace the `resourceOrderCreate` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This function will create a new HashiCups order and Terraform resource.

```{{copy}}
func resourceOrderCreate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
  c := m.(*hc.Client)

  // Warning or errors can be collected in a slice type
  var diags diag.Diagnostics

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

  o, err := c.CreateOrder(ois)
  if err != nil {
    return diag.FromErr(err)
  }

  d.SetId(strconv.Itoa(o.ID))

  return diags
}
```
</details>
