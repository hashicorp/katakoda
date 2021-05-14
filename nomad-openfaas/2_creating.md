# Using the faas-cli tool

To create a new function you can use the OpenFaaS command-line tool `faas-cli`,
which is available for many platforms such as Windows, Linux, and macOS.

OpenFaaS supports several languages such as Node Python, and Golang, to see
the officially supported templates run the command `faas-cli template pull
&& faas-cli new --list`{{execute}}

You can also use a community submitted templates using the `faas-cli pull`
command. You are going to use the Golang template to create a function called
`echo`.

Run the command now to create your function: `faas-cli new -lang go
echo`{{execute}}

This will create several files for you in the current folder:

```bash
$ tree -L 2
.
├── echo
│   └── handler.go
├── echo.yml
└── template
    ├── csharp
    ├── go
    ├── go-armhf
    ├── node
    ├── node-arm64
    ├── node-armhf
    ├── python
    ├── python-armhf
    ├── python3
    └── ruby
```

The handler.go file which contains the example function code. If you look at it we
can see it contains a single function with a simple interface.

`vim echo/handler.go`{{execute}}

Type `:x` to quit Vim.

The next step is to build the function and to deploy it to Nomad. Before you do,
you need to edit the echo.yml file and change the image name so you can push the
image to a docker registry.

`vim echo.yml`{{execute}}

You can push the image to your personal registry. There is also a local
registry running in this environment.

<https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com>

Edit the echo.yml file and change

- The gateway to your local gateway to:

  - <https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/>

- The image URL to:

  - <https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/echo>

  - **Remove the https:// it's added by Katacoda automatically**

Your echo.yml file should be similar to the following.

```yaml
provider:  
  name: faas  
  gateway: https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/  

functions:  
  echo:  
    lang: go  
    handler: ./echo  
    image: https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/echo
```

**Remove the https:// from the image URL**

Adding the gateway to your `echo.yml` allows you to deploy and invoke your
functions without needing to specify the gateway flag in the command line.
