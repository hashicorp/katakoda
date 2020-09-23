Schemas allow the providers to map the API response to a Terraform resource. In this step, you will define the schema for a HashiCups order.

> If you’re stuck, refer to the complete schema at the end of this step to see the changes implemented in this step.

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

## Define Order schema

Open `hashicups/resource_order.go`{{open}}.

An `Order` is comprised of an ID and `items`. The order ID will be set to the resource's ID, so you only need to define `items`.

`items` is a required list of `OrderItems`. 

Define the `items` schema (line 17). It should be type `schema.TypeList` with required set to `true`.

<details style="padding-bottom: 1em;">
<summary>Hint</summary>
```
"items": &schema.Schema{
    Type:     schema.TypeList,
    Required: true,
    Elem: &schema.Resource{}
}
```
</details>

### Define OrderItems schema

`OrderItems` contains two items: `coffee` and `quantity`. 

#### Define Coffee schema

`coffee` is a nested object (an object inside another object, i.e. `OrderItems`). 

There are two ways to nest objects using the Terraform Plugin SDK v2.

1. The first is to define the nested object as an `schema.TypeList` with 1 item. This is currently the closest way to emulate a nested object, and **what you will do in this workshop**.

1. The second is to use a `schema.TypeMap`. This method may be preferable if you only require a key value map of primitive types. However, you should use a validation function to enforce required keys.

Define the `coffee` schema inside the `item`'s `Elem` Property. The schema should be type `schema.List` with a maximum of one item.

<details style="padding-bottom: 1em;">
<summary>Hint</summary>

```
items": &schema.Schema{
    Type:     schema.TypeList,
    Required: true,
    Elem: &schema.Resource{
        Schema: map[string]*schema.Schema{
            "coffee": &schema.Schema{
                Type:     schema.TypeList,
                MaxItems: 1,
                Required: true,
                Elem: &schema.Resource{}
            }
        }
    }
}
```
</details>

Then, define each coffee properties inside the `coffee`'s `Elem` property.

Each property type maps to an appropriate `schema.Type`. To create a new order, only the coffee ID is required. The other properties are computed.

| Property    | Type    | SchemaType        | Other    |
| ----------- | ------- | ----------------- | -------- |
| id          | int     | schema.TypeInt    | Required |
| name        | string  | schema.TypeString | Computed |
| teaser      | string  | schema.TypeString | Computed |
| description | string  | schema.TypeString | Computed |
| price       | float64 | schema.TypeInt    | Computed |
| image       | string  | schema.TypeString | Computed |


<details style="padding-bottom: 1em;">
<summary>Hint</summary>

```
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
```
</details>

#### Define quantity schema

`quantity` is a required integer and a property of `OrderItems`.

Define the `quantity` schema inside the `items` element schema. It should be type `schema.TypeInt` with required set to `true`.

<details style="padding-bottom: 1em;">
<summary>Hint</summary>
```
"quantity": &schema.Schema{
    Type:     schema.TypeInt,
    Required: true,
},
```
</details>

You have defined the HashiCups order schema. In the next step, you will use this schema to add create functionality to the HashiCups provider. You can view the complete schema below to confirm your work.

<details style="padding-bottom: 1em;">
<summary>Complete schema</summary>
<br/>
Replace the line `Schema: map[string]*schema.Schema{}`, in your resourceOrder function with the following schema. Notice how the order resource schema resembles the API client's `Order` type.

```
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
```
</details>