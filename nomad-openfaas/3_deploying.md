We can now build our function using the command line:
`faas-cli build --yaml echo.yml`{{execute}}

The build process executes in a Docker container which means that other than Docker and the faas-cli you do not require any further dependencies installed. 

Before we deploy the function we first need to push it to a Docker registry, we can  do this using the `faas-cli push` command.

`faas-cli push --yaml echo.yml`{{execute}}

We can now deploy the function to OpenFaaS on our Nomad cluster.

`faas-cli deploy --yaml echo.yml`{{execute}}

If you again look at the jobs running on Nomad you should now see two:

`nomad status`{{execute}}
