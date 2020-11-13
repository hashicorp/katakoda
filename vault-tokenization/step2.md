Create a new `app-policy` policy allowing client apps to request secrets to be tokenized.

```
vault policy write app-policy -<<EOF
# To request data encoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/encode/mobile-pay" {
   capabilities = [ "update" ]
}

# To request data decoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/decode/mobile-pay" {
   capabilities = [ "update" ]
}

# To validate the token
path "transform/validate/mobile-pay" {
   capabilities = [ "update" ]
}

# To retrieve the metadata belong to the token
path "transform/metadata/mobile-pay" {
   capabilities = [ "update" ]
}

# To check and see if the secret is tokenized
path "transform/tokenized/mobile-pay" {
   capabilities = [ "update" ]
}
EOF
```{{execute T1}}

Now, create a token with `app-policy` attached. Set the time-to-live (TTL) to 10 minutes, and store the generated token in a file named, `app-token.txt`.

```
vault token create  -policy=app-policy -ttl=10m \
   -format=json | jq -r ".auth.client_token" > app-token.txt
```{{execute T1}}

## Encode secrets

Login with the generated client token instead of using the root token.

```
vault login $(cat app-token.txt)
```{{execute T1}}

Use the client token to encode a value with the `mobile-pay` role with some metadata.

```
vault write -format=json transform/encode/mobile-pay \
   value=1111-2222-3333-4444 \
   transformation=credit-card \
   ttl=8h \
   metadata="Organization=HashiCorp" \
   metadata="Purpose=Travel" \
   metadata="Type=AMEX" | jq -r ".data.encoded_value" > card-encoded.txt
```{{execute T1}}

The `ttl` value is an optional parameter. Remember that the `max_ttl` was set to 24 hours when you created the `credit-card` transformation. You can overwrite that value to make the token's TTL to be shorter.

Retrieve the metadata of the token.

```
vault write transform/metadata/mobile-pay \
   value=$(cat card-encoded.txt) \
   transformation=credit-card
```{{execute T1}}

<div style="background-color:#fbe5e5; color:#fcf6ea; border:1px solid #f8cfcf; padding:1em; border-radius:3px; margin:24px 0;">
<p>
Notice that `expiration_time` is displayed. Since you have overwritten the `max_ttl`, the `ttl` is set to 8 hours.
</p></div>


Validate the token value. This determines if the provided tokenized value (`card-encoded.txt`) is valid and unexpired.

```
vault write transform/validate/mobile-pay \
   value=$(cat card-encoded.txt) \
   transformation=credit-card
```{{execute T1}}

Validate that the credit card number has been tokenized already.

```
vault write transform/tokenized/mobile-pay \
   value=1111-2222-3333-4444 \
   transformation=credit-card
```{{execute T1}}

Retrieve the original plaintext credit card value.

```
vault write transform/decode/mobile-pay \
   transformation=credit-card \
   value=$(cat card-encoded.txt)
```{{execute T1}}
