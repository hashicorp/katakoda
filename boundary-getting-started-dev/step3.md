Open a new tab in the Katacoda terminal pane by using the "+" symbol and
selecting "Open New Terminal".

Display the help message for `boundary authenticate` command.

```shell
boundary authenticate help
```{{execute}}

The CLI supports password authentication.

Authenticate with the password method using `auth-method-id`, `login-name`, and
`password` options and save the token to a file named `.boundary-token`.

```shell
boundary authenticate password \
    -auth-method-id=ampw_1234567890 \
    -login-name=admin \
    -password=password \
    -keyring-type=none \
    -format=json | jq -r ".token" > .boundary-token
```{{execute}}

- The `auth-method-id` is the Generated Auth Method Id: `ampw_1234567890`
- The `login-name` is the Generated Auth Method Login Name: `admin`
- The `password` is the Generated Auth Method Password: `password`

> The command displays `Error opening keyring: Specified keyring backend not
available` because this environment does not run a key management system.

Set the `BOUNDARY_TOKEN` environment variable to the authentication token.

```shell
export BOUNDARY_TOKEN=$(cat .boundary-token)
```{{execute}}

Future requests within the shell session use this token to authenticate until
it expires.
