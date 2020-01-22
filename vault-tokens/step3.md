To limit the number of times that a token can be used, pass the `-use-limit` parameter with desired count.

```
vault token create -use-limit=<integer>
```

Execute the following command to create a token with use limit of **3**, and save the generated token in a file named, `use_limit_token.txt`.

```
vault token create -use-limit=3 -policy=base \
      -format=json | jq -r ".auth.client_token" > use_limit_token.txt
```{{execute T1}}

Login with the generated token:

```
vault login $(cat use_limit_token.txt)
```{{execute T1}}

Now, test the token with use limit by executing some vault commands:

```
vault token lookup
```{{execute T1}}

Execute the following command to write some secrets at `secret/training_test`:

```
vault kv put secret/training_test year="2018"
```{{execute T1}}

The command should execute successfully.

Now, let's try a negative test. The following command fails since the use limit was reached and no more usage left with this token. Once the use limit was reached, the token gets revoked automatically.

```
vault kv get secret/training_test
```{{execute T1}}

Log back in with `root` token:

```
vault login root
```{{execute T1}}
