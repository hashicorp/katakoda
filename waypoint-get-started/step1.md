In this tutorial, you'll run a Waypoint server in Docker and then deploy an application.

## Install Waypoint

Install the `waypoint` binary. The environment has already been configured with the official HashiCorp repository.

`sudo apt-get update && sudo apt-get install waypoint`{{execute}}

Clone a copy of the example source code.

`git clone https://github.com/hashicorp/waypoint-examples.git`{{execute}}

Navigate to the example code for the static HTML and CSS application. The `docker` directory also includes code for other languages, but we've chosen the static example because it is the quickest to build.

`cd waypoint-examples/docker/static`{{execute}}

## Install the Waypoint server

Install the Waypoint server to the local Docker instance. To ensure that you have the most recent version, `pull` it with Docker.

`docker pull hashicorp/waypoint:latest`{{execute}}

Install the Waypoint server.

`waypoint install -platform=docker -accept-tos`{{execute}}

## Initialize the application

We've created a `waypoint.hcl` configuration file for you. View it by clicking this link.

`waypoint-examples/docker/static/waypoint.hcl`{{open}}

Now, initialize the application by typing `init`. This will validate the configuration.

`waypoint init`{{execute}}

## Run `waypoint up`

To deploy, run `up`. This will take a few minutes while it downloads the Docker image, builds a custom image, and deploys it to the local Docker.

`waypoint up`{{execute}}

A URL will be displayed in the output. Visit the URL to see your application running with Waypoint.

## Explore and debug

Waypoint includes commands for debugging and monitoring. The `logs` command shows the activity in the application.

`waypoint logs`{{execute}}

Press `Ctrl-C` to quit.

The `exec` command opens a session inside the running container.

`waypoint exec /bin/bash`{{execute}}

Try a command like `ls /var/www`. Type `exit` to leave the session.

`exit`{{execute}}

Visit the Waypoint web UI. Because this session is being run remotely, you must manually generate an authentication token.

**NOTE:** You may need to widen your web browser so the entire token can be displayed.

`waypoint token new`{{execute}}

Visit the [Waypoint web UI](https://[[HOST_SUBDOMAIN]]-9702-[[KATACODA_HOST]].environments.katacoda.com/). Click "Authenticate" and enter the token shown on the previous command.

## Change and deploy

Making changes to an application and deploying it again can be done with the same command: `waypoint up`.

Edit the `h1` section in `public/index.html` to say "This static HTML app was deployed today." Then, run `up`.

`waypoint up`{{execute}}

After the command completes, visit the URL displayed in the output.

## Destroy

When you are done, destroy the application with the `destroy` command.

`waypoint destroy`{{execute}}
