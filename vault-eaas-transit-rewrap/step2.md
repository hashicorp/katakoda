Display the limited scope policy stored in `rewrap_example.hcl`.

```shell
cat rewrap_example.hcl
```{{execute}}

Create the `rewrap_example` policy.

```shell
vault policy write rewrap_example ./rewrap_example.hcl
```{{execute}}

Create a token with the `rewrap_example` policy.

```shell
vault token create -policy=rewrap_example
```{{execute}}

The output displays a token capable of using the transit key `my_app_key`.

Create another token and store the token in the variable `APP_TOKEN`.

```shell
APP_TOKEN=$(vault token create -format=json -policy=rewrap_example | jq -r ".auth.client_token")
```{{execute}}

Display the `APP_TOKEN`.

```shell
echo $APP_TOKEN
```{{execute}}

The application uses this token to seed the database.