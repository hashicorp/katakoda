Schemas allow the providers to map the API response to a Terraform resource. In this step, you will complete the HashiCups order schema.

> If you’re stuck, refer to the complete schema at the end of this step to see the changes implemented in this step.

## Explore existing schema

The [HashiCups API Client](https://github.com/hashicorp-demoapp/hashicups-client-go) defines a HashiCups order as the following.

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

An `Order` is comprised of an ID and `items`.
- The order ID will be set to the resource's ID. 
- `items`, a required list of `OrderItems`, has been defined for you

On line 18, items is defined as a `schema.TypeList` and its `Required` attribute is set to `true`. 

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

On line 23, `quantity` is defined as a `schema.TypeInt` and its `Required` attribute is set to `true`. Notice how the quantity is nested in the item's `Elem` attribute.

```
"quantity": &schema.Schema{
    Type:     schema.TypeInt,
    Required: true,
},
```

### Define Coffee schema

`coffee` is a nested object (an object inside another object, i.e. `OrderItems`). 

There are two ways to nest objects using the Terraform Plugin SDK v2.

On line 28, `coffee` is defined as a `schema.TypeList` with 1 item. This is one of two ways to nest objects using the Terraform Plugin SDK v2, and is the closest way to emulate a nested object.

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

Define each coffee properties inside the `coffee`'s `Elem` property.

Each property type maps to an appropriate `schema.Type`. To create a new order, only the coffee ID is required. The other properties are computed.

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

Replace the schema on line 31 with the following code snippet. This defines each properties in the coffee object.

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
Replace the line `Schema: map[string]*schema.Schema{}`, in your resourceOrder function with the following schema. Notice how the order resource schema resembles the API client's `Order` type.

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