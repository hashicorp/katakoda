You can now build your function using the command line.

`faas-cli build --yaml echo.yml`{{execute}}

The build process executes in a Docker container which means that other than
Docker and the faas-cli you do not require any further dependencies installed.

Before you deploy the function you first need to push it to a Docker registry,
you can do this using the `faas-cli push` command.

`faas-cli push --yaml echo.yml`{{execute}}

Deploy the function to OpenFaaS on your Nomad cluster.

`faas-cli deploy --yaml echo.yml`{{execute}}

Look at the jobs running on Nomad, you should now see two.

`nomad status`{{execute}}
