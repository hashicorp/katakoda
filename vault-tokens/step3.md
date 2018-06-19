To limit the number of times that a token can be used, pass the `-use-limit` parameter with desired count.

```
vault token create -use-limit=<integer>
```

Execute the following command to create a token with use limit of **3**, and save the generated token in a file named, `use_limit_token.txt`.

```
vault token create -use-limit=3 -policy=base \
      -format=json | jq -r ".auth.client_token" > use_limit_token.txt
```{{execute T2}}

Login with the generated token:

```
vault login $(cat use_limit_token.txt)
```{{execute T2}}

Now, test the token with use limit by executing some vault commands:

```
vault token lookup
```{{execute T2}}

Execute the following command to write some secrets at `secret/training_test`:

```
vault kv put secret/training_test year="2018"
```{{execute T2}}

The command should execute successfully.

Now, try to read the data that you just wrote.

```
vault kv get secret/training_test
```{{execute T2}}

This fails since the use limit was reached. Once the use limit was reached, the token gets revoked automatically.

Log back in with `root` token:

```
vault login root
```{{execute T2}}
