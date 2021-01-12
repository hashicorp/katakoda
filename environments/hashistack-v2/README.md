# Running Stack in Docker

The Dockerfile will build a ubuntu 18.0.4 image using the build scripts in this
directory.

## Quickstart 

The following will create a fresh terminal session using the image:

```shell
make && docker exec -it katacoda bash
```

> The container is reset each time the make command is run.

# Manual instructions

Use these steps if you prefer to change or update the docker flags.

Built the docker container

```shell
docker build \
         --rm \
         -t \
         katacoda:latest
```

## Run Katacoda image.

Launch the katacoda container in the background.

```shell
docker run \
  -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name \
  katacoda \
  katacoda
```

> The -v flag is optional but allows docker (in docker) to use the hosts docker api.

## Run Katacoda scenario

Connect to the katacoda container for interactive testing.


```shell
docker exec -it katacoda bash
```

## Resetting the container

View the running containers

```shell
docker ps
CONTAINER ID        IMAGE               COMMAND               CREATED             STATUS              PORTS               NAMES
08a114d9aa4d        5fdc74d879ca        "tail -f /dev/null"   3 minutes ago       Up 3 minutes                            katacoda
```

Remove the running container

```shell
docker rm -f katacoda
```

> All session state will be lost.
