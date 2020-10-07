The Vault client applications must have the following in their policy to perform data encoding and decoding using the Transform secrets engine enabled at `transform/`.

```
# To request data encoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/encode/*" {
   capabilities = [ "update" ]
}

# To request data decoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/decode/*" {
   capabilities = [ "update" ]
}
```

## Encode secrets

To encode secrets using the `payments` role, execute the following command.

```
vault write transform/encode/payments value=1111-2222-3333-4444
```{{execute T1}}

Notice that the returned encoded value maintains the format of the input data.

Execute the command again and store the encoded value in a file named, `card-encoded.txt`.

```
vault write -format=json transform/encode/payments value=1111-2222-3333-4444 \
   | jq -r ".data.encoded_value" > card-encoded.txt
```{{execute T1}}

Open the `card-encoded.txt` to see the returned encoded value.

```
cat card-encoded.txt
```{{execute T1}}

## Decode secrets

To decode the value encoded with `payments` role, execute the following command.

```
vault write transform/decode/payments value=$(cat card-encoded.txt)
```{{execute T1}}

<br />

This was too easy!
