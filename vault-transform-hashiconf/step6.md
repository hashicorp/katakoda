When you need to encode more than one secret value, you can send multiple secrets in a request payload as **batch_input** instead of invoking the API endpoint multiple times to encode secrets individually.

**Example Scenario 1:**

You received a credit card number, British passport number and a phone number of a customer and wish to transform all these secrets using the `payments` role.

The API request payload can contain all secrets associated with transformations associated with the `payments` role.
Examine the `input-multiple.json` file containing the test data.

```
cat input-multiple.json
```{{execute T1}}

Invoke the `transform/encode/payments` endpoint.

```
curl --header "X-Vault-Token: root" --request POST \
       --data @input-multiple.json \
       http://127.0.0.1:8200/v1/transform/encode/payments | jq ".data"
```{{execute T1}}

<br />

**Example Scenario 2:**

An on-prem database stores corporate card numbers and your organization decided to migrate the data to another database. You wish to encode those card numbers before storing them in the new database.

To encode multiple card numbers at once, set the values as `batch_input`. If the role has more than one transformation associate with it, be sure to specify the name of transformation as well.

The request payload can contain multiple card numbers. Examine the `payload-batch.json` file containing the test data.

```
cat payload-batch.json
```{{execute T1}}

Execute the `transform/encode/payments` endpoint.

```
curl --header "X-Vault-Token: root" --request POST \
       --data @payload-batch.json \
       http://127.0.0.1:8200/v1/transform/encode/payments | jq ".data"
```{{execute T1}}

Similarly, to decode multiple card numbers, set the values as `batch_input`.

For example:

```
$ tee payload-batch.json <<EOF
{
  "batch_input": [
    { "value": "7998-7227-5261-3751", "transformation": "card-number" },
    { "value": "2026-7948-2166-0380", "transformation": "card-number" },
    { "value": "3979-1805-7116-8137", "transformation": "card-number" },
    { "value": "0196-8166-5765-0438", "transformation": "card-number" }
  ]
}
EOF

$ curl --header "X-Vault-Token: root" \
       --request POST \
       --data @payload-batch.json \
       http://127.0.0.1:8200/v1/transform/decode/payments | jq ".data"
{
  "batch_results": [
    {
      "decoded_value": "1111-1111-1111-1111"
    },
    {
      "decoded_value": "2222-2222-2222-2222"
    },
    {
      "decoded_value": "3333-3333-3333-3333"
    },
    {
      "decoded_value": "4444-4444-4444-4444"
    }
  ]
}
```
