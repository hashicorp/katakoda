Dev mode brings up a fully functioning instance of Boundary which includes:

- A controller server
- A worker server
- A Postgres database

These components are ephemeral; therefore, data is not persisted and convenient
for quick testing.

Check the help message for `boundary dev` command.

```shell
$ boundary dev -h
```{{execute}}

There are optional flags available to configure Boundary environment through the
command line.

Start Boundary in development mode.

```shell
boundary dev -api-listen-address=0.0.0.0:9200
```{{execute}}

Boundary starts in dev mode with default authentication credentials and
a set of pre-defined [resources](https://boundaryproject.io/docs/concepts/domain-model).

These admin credentials enable you to log in the Boundary console.

- Generated Auth Method Id: `ampw_1234567890`
- Generated Auth Method Login Name: `admin`
- Generated Auth Method Password: `password`
