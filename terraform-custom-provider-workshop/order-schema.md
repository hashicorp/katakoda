Schemas allow Terraform providers to map the API response to a Terraform resource. In this step, you will complete the HashiCups order schema.

> If you get stuck, refer to the complete schema at the end of this step to see the changes implemented in this step.

## Explore existing schema

The [HashiCups API Client](https://github.com/hashicorp-demoapp/hashicups-client-go) defines a HashiCups order as the following. You'll use this as a reference to define the order schema using the Terraform Plugins SDK.

<details style="padding-bottom: 1em;" open>
<summary>HashiCups Order Definition</summary>

```
// Order -
type Order struct {
	ID    int         `json:"id,omitempty"`
	Items []OrderItem `json:"items,omitempty"`
}

// OrderItem -
type OrderItem struct {
	Coffee   Coffee `json:"coffee"`
	Quantity int    `json:"quantity"`
}

// Coffee -
type Coffee struct {
	ID          int          `json:"id"`
	Name        string       `json:"name"`
	Teaser      string       `json:"teaser"`
	Description string       `json:"description"`
	Price       float64      `json:"price"`
	Image       string       `json:"image"`
}
```
</details>

Open `hashicups/resource_order.go`{{open}}.

An order represents a customer ordering coffee from the Hashicups API. Each order is made up of an ID and `items`.

- The order ID will be set to the resource's ID. 
- `items`, a required list of `OrderItems`, has been defined for you

On line 19, items is defined as a `schema.TypeList` and its `Required` attribute is set to `true`. 

```
"items": &schema.Schema{
    Type:     schema.TypeList,
    Required: true,
    Elem: &schema.Resource{
      ...
    }
}
```

`OrderItems` contains two items: `quantity` and `coffee`.

`quantity` is a required integer and a property of `OrderItems`.

On line 24, `quantity` is defined as a `schema.TypeInt`, its `Required` attribute is set to `true`, and it is nested in the `"items"`'s `Elem` attribute.

```
"quantity": &schema.Schema{
    Type:     schema.TypeInt,
    Required: true,
},
```

### Define Coffee schema

`coffee` is a nested object — an object inside another object. In this case, `coffee` is nested inside of `items`.

The Terraform Plugin SDK v2 currently does not support nested objects; however, you can emulate one using a list of 1 item.

On line 29, `coffee` is defined as a `schema.TypeList` with 1 item.

```
items": &schema.Schema{
    Type:     schema.TypeList,
    Required: true,
    Elem: &schema.Resource{
        ...
        // Define Coffee Schema
        Schema: map[string]*schema.Schema{
            "coffee": &schema.Schema{
                Type:     schema.TypeList,
                MaxItems: 1,
                Required: true,
                Elem: &schema.Resource{
                  // ** | Coffee attributes
                  Schema: map[string]*schema.Schema{},
                }
            }
        }
    }
}
```

> Interactive Code Portion

Define each coffee properties inside the `coffee`'s `Elem` property by adding properties to the empty map found on line 35. 

The keys will be the property names, and the values will be `&schema.Schema` objects defining the `Type` and `Required`/`Computed` values, as shown in the table below. Each of these entries will be similar to the definition of `"quantity"` found on lines 24-27.

| Property    | Type    | SchemaType        | Other    |
| ----------- | ------- | ----------------- | -------- |
| id          | int     | schema.TypeInt    | Required |
| name        | string  | schema.TypeString | Computed |
| teaser      | string  | schema.TypeString | Computed |
| description | string  | schema.TypeString | Computed |
| price       | float64 | schema.TypeFloat  | Computed |
| image       | string  | schema.TypeString | Computed |


<br/>
<details style="padding-bottom: 1em;">
<summary>Hint</summary>

Replace the schema on line 35 with the following code snippet. This defines each properties in the coffee object.

Clicking on "Copy to Editor" will automatically replace the schema. 

<pre class="file" data-filename="hashicups/resource_order.go" data-target="insert" data-marker="Schema: map[string]*schema.Schema{},">
Schema: map[string]*schema.Schema{
    "id": &schema.Schema{
        Type:     schema.TypeInt,
        Required: true,
    },
    "name": &schema.Schema{
        Type:     schema.TypeString,
        Computed: true,
    },
    "teaser": &schema.Schema{
        Type:     schema.TypeString,
        Computed: true,
    },
    "description": &schema.Schema{
        Type:     schema.TypeString,
        Computed: true,
    },
    "price": &schema.Schema{
        Type:     schema.TypeFloat,
        Computed: true,
    },
    "image": &schema.Schema{
        Type:     schema.TypeString,
        Computed: true,
    },
},
</pre>
</details>

To format your code, run `go fmt ./...`{{execute}} then close and reopen your file (`hashicups/resource_order.go`{{open}}). This allows KataCoda to refresh your file in the editor.

## Next Steps

You have defined the HashiCups order schema. 

In the next step, you will use this schema to add create functionality to the HashiCups provider. 

You can view the complete schema below to confirm your work.

<details style="padding-bottom: 1em;">
<summary>Complete schema</summary>
<br/>

Replace the schema in your resourceOrder function with the following schema (line 18). Notice how the order resource schema resembles the HashiCups API client's `Order` type.

<pre class="file" data-target="clipboard">
Schema: map[string]*schema.Schema{
  "items": &schema.Schema{
    Type:     schema.TypeList,
    Required: true,
    Elem: &schema.Resource{
      Schema: map[string]*schema.Schema{
        "coffee": &schema.Schema{
          Type:     schema.TypeList,
          MaxItems: 1,
          Required: true,
          Elem: &schema.Resource{
            Schema: map[string]*schema.Schema{
              "id": &schema.Schema{
                Type:     schema.TypeInt,
                Required: true,
              },
              "name": &schema.Schema{
                Type:     schema.TypeString,
                Computed: true,
              },
              "teaser": &schema.Schema{
                Type:     schema.TypeString,
                Computed: true,
              },
              "description": &schema.Schema{
                Type:     schema.TypeString,
                Computed: true,
              },
              "price": &schema.Schema{
                Type:     schema.TypeInt,
                Computed: true,
              },
              "image": &schema.Schema{
                Type:     schema.TypeString,
                Computed: true,
              },
            },
          },
        },
        "quantity": &schema.Schema{
          Type:     schema.TypeInt,
          Required: true,
        },
      },
    },
  },
},
</pre>
</details>