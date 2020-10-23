Waypoint tutorial.

## Example code

`sudo apt-get update && sudo apt-get install waypoint`{{execute}}

`git clone https://github.com/hashicorp/waypoint-examples.git`{{execute}}

`cd waypoint-examples/docker/ruby`{{execute}}

`docker pull hashicorp/waypoint:latest`{{execute}}

`waypoint install -platform=docker -accept-tos`{{execute}}

`waypoint.hcl`{{open}}

`waypoint init`{{execute}}

`waypoint up`{{execute}}

`waypoint exec /bin/bash`{{execute}}

Try `ps aux` or `ls`

`waypoint logs`{{execute}}

`waypoint token new`{{execute}}

Display page allowing user to select port: https://[[HOST_SUBDOMAIN]]-9702-[[KATACODA_HOST]].environments.katacoda.com/

`waypoint destroy`{{execute}}
