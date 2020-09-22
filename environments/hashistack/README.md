# Running Stack in Docker

The Dockerfile will build an Ubuntu image using the build scripts in this directory.

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

# Running Automated tests

The automated tests will run the [inspec](https://www.chef.io/products/chef-inspec) controls against the docker container built by `make`

This will generate an HTML and Command line report on the success and failure.

You can execute the tests ( which also builds the container ) using:

```shell
./spec.sh
```

```
Profile: tests from ./controls/packer_contol.rb (tests from ..controls.packer_contol.rb)
Version: (not specified)
Target:  docker://0540aabbf4d6189a8466e4d40dc4eea125986db07aba06633f8246f9a73cd7ca

  ✔  packer: Packer should be installed
     ✔  System Package packer is expected to be installed


Profile: tests from ./controls/terraform_contol.rb (tests from ..controls.terraform_contol.rb)
Version: (not specified)
Target:  docker://0540aabbf4d6189a8466e4d40dc4eea125986db07aba06633f8246f9a73cd7ca

  ✔  terraform: Terraform should be installed
     ✔  System Package terraform is expected to be installed
     ✔  File /usr/local/bin/sentinel is expected to be executable


Profile: tests from ./controls/vault_control.rb (tests from ..controls.vault_control.rb)
Version: (not specified)
Target:  docker://0540aabbf4d6189a8466e4d40dc4eea125986db07aba06633f8246f9a73cd7ca

  ✔  vault: Vault should be installed
     ✔  System Package vault is expected to be installed


Profile Summary: 5 successful controls, 0 control failures, 0 controls skipped
Test Summary: 12 successful, 0 failures, 0 skipped

```
