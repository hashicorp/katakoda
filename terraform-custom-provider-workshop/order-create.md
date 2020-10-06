Now that you have defined the `order` resource schema, you will define the `resourceOrderCreate` function.

The create function uses the HashiCups API client to create a new order.

> If you get stuck, refer to the complete create function at the end of this step to see the changes implemented in this step.

The `resourceOrderCreate` function:
1. retrieves HashiCups API Client from meta parameter
1. maps the order `schema.Resource` to `[]hc.OrderItems{}`
1. invokes the `CreateOrder` function on the HashiCups client
1. **sets order ID as resource ID**
1. maps response (`hc.Order`) to order `schema.Resource` (similar to `resourceOrderRead`)

The create function is named `resourceOrderCreate` and starts on line 72 in `hashicups/resource_order.go`{{open}}. Most of these steps have been implemented, you will only set the order ID as the resource ID.

## Explore the `resourceOrderCreate` function

On line 73, the function first retrieves the authenticated HashiCups API client from the meta parameter.

```
c := m.(*hc.Client)
```

Then, the function retrieves the `OrderItems` from the schema's `items` (line 79). 

```
items := d.Get("items").([]interface{})
```

It maps these properties into `[]hc.OrderItem{}` which will be used to invoke the HashiCups API client's `CreateOrder` function. Notice how each coffee object (`co`) is the first element of a `[]interface{}`. This is because coffee is represented as a `schema.TypeList` of one object in the schema.

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

Next, the create function invokes the `CreateOrder` function  on the HashiCups client with `ois`, the mapped `[]hc.OrderItems{}`, as an argument (line 99).

If the `CreateOrder` function fails, it returns the error.

```
o, err := c.CreateOrder(ois)
if err != nil {
  return diag.FromErr(err)
}
```

## Set order ID as resource ID

> Interactive Code Portion

Next, use `SetID` to set the resource ID to the order ID. The resource ID must be a non-blank string that Terraform will use to identify the resource in future operations. If no ID is set, Terraform assumes the resource was not created successfully; as a result, no state will be saved for that resource.

Because order ID is returned as an integer, you must convert it to a string before setting it as your resource ID.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker="// ** | Set order ID as resource ID">
// ** | Set order ID as resource ID
  d.SetId(strconv.Itoa(o.ID))
</pre>

To format your code, run `go fmt ./...`{{execute}} then close and reopen your file (`hashicups/resource_order.go`{{open}}). This allows KataCoda to refresh your file in the editor.

## Add dependencies

> Interactive Code Portion

Since the `resourceOrderCreate` function uses `strconv` to convert the ID into a string, you will need to import the `strconv` library. The import statement will be found at the top of your `hashicups/resource_order.go`{{open}} file.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker='// ** | Add "strconv" package'>
// ** | Add "strconv" package
  "strconv"
</pre>

To format your code, run `go fmt ./...`{{execute}} then close and reopen your file (`hashicups/resource_order.go`{{open}}). This allows KataCoda to refresh your file in the editor.

## Next steps

You have implemented the create function. 

In the next step, you implement a complex read function to populate the order schema.

You can view the complete create function below to confirm your work.

<details style="padding-bottom: 1em;">
<summary>Complete create function</summary>
<br/>

Since the `resourceOrderCreate` function uses `strconv` to convert the ID into a string, remember to import the `strconv` library. Remember to also import the HashiCups API client library.

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker='// Add "strconv" package'>
// Add "strconv" package
  "strconv"
</pre>

Replace the `resourceOrderCreate` function in `hashicups/resource_order.go`{{open}} with the following code snippet. This function will create a new HashiCups order and Terraform resource.

<pre class="file" data-target="clipboard">
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
</pre>
</details>
