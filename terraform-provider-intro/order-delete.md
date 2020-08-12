Finally, you can delete resources in Terraform. Run `terraform destroy`. 

`terraform destroy`{{execute T2}}

Remember to confirm the apply step with a `yes`{{execute T2}}.

When the destroy step completes, the provider has destroyed the order resource, reflected by an empty state file.


### Verify order deleted

Verify the order was deleted by retrieving the order details via the API. 

`curl -X GET  -H "Authorization: ${HASHICUPS_TOKEN}" localhost:19090/orders/1 | jq`{{execute T2}}

The response will look similar to the following.

```
{}
```

The order is blank, as expected.