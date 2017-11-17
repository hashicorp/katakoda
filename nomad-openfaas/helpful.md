OpenFaaS allows you to run a private functions as a service, on top of the Nomad scheduler.  Functions are packaged in Docker Containers which enables you to work in any language and also interact with any software which can also be installed in the container.
This Katacoda environment already has Nomad, Consul and OpenFaaS installed and running.  You can interact with nomad using the command line tools:

`nomad status`{{execute}}

We can also interact with OpenFaaS using the `faas-cli` tool, note that we need to specify the gateway as this defaults to localhost and our gateway is running at `http://host01:8080/`  

`faas-cli list -gateway=http://host01:8080/`{{execute}}

## Creating a new function
We can create a new function by running the following command in the CLI:

`faas-cli new gofunction -lang go`{{execute}}

```bash
$ faas-cli new gofunction -lang go
#...
2017/11/17 11:35:49 Cleaning up zip file...

Folder: gofunction created.
#...
Function created in folder: gofunction
Stack file written: gofunction.yml
``` 

The command will create two folders and one file in the current directory:

```bash
$ tree -L 1  
.
├── gofunction
├── gofunction.yml
└── template

2 directories, 1 file
```

The `gofunction` folder is where the source code for your application will live by default there is the main entry point called `handler.go`:

```go
package function

import (
    "fmt"
)

// Handle a serverless request
func Handle(req []byte) string {
    return fmt.Sprintf("Hello, Go. You said: %s", string(req))
}
```

The Handle method receives the payload sent by calling the function as a slice of bytes and expects any output to be returned as a string.  For now, let’s keep this function the same and run through the steps for building the function.  The first thing we need to do is to edit the `gofunction.yml.` file and change the image name so that we can push this to a Docker repo that our Nomad cluster will be able to pull.  Also, change the gateway address to the location of your OpenFaaS gateway.  Changing the gateway in this file saves us providing the location as an alternate parameter.

```yaml
provider:
  name: faas
  gateway: http://localhost:8080

functions:
  gofunction:
    lang: go
    handler: ./gofunction
    image: nicholasjackson/gofunction
```

### Building our new function
Next step is to build the function; we can do this with the `faas-cli build` command:

```bash
$ faas-cli build -yaml gofunction.yml 
#...
Step 16/17 : ENV fprocess "./handler"
 ---> Using cache
 ---> 5e39e4e30c60
Step 17/17 : CMD ./fwatchdog
 ---> Using cache
 ---> 2ae72de493b7
Successfully built 2ae72de493b7
Successfully tagged nicholasjackson/gofunction:latest
Image: gofunction built.
[0] < Builder done.
```

The `build` command execute the Docker build command with the correct Dockerfile for your language.  All code is compiled inside of the container as a multi-stage build before being packaged into an Image.

### Pushing the function to the Docker repository
We can either use the `faas-cli push` command to push this to a Docker repo, or we can manually push.

```bash
$ faas-cli push -yaml gofunction.yml 
[0] > Pushing: gofunction.
The push refers to a repository [docker.io/nicholasjackson/gofunction]
cc9df684d32a: Pushed 
4e12ae9c1d69: Pushed 
cdcffb5144dd: Pushed 
10d64a26ddb0: Pushed 
dbbae7ea208f: Pushed 
2aebd096e0e2: Pushed 
latest: digest: sha256:57c0143772a1e6f585de019022203b8a9108c2df02ff54d610b7252ec4681886 size: 1574
[0] < Pushing done.
```

### Deploying the function
To deploy the function we can again use the `faas-cli` tool to deploy the function to our Nomad cluster:

```bash
$ faas-cli deploy -yaml gofunction.yml
Deploying: gofunction.
Removing old function.
Deployed.
URL: http://192.168.1.113:8080/function/gofunction

200 OK
```

If you run the `nomad status` command, you will now see the additional job running on your Nomad cluster.

```bash
$ nomad status
ID                   Type     Priority  Status   Submit Date
OpenFaaS-gofunction  service  1         running  11/17/17 11:52:59 GMT
faas-monitoring      service  50        running  11/15/17 14:43:11 GMT
faas-nomadd          system   50        running  11/15/17 11:00:31 GMT
```

### Running the function
To run the function, we can simply curl the OpenFaaS gateway and pass our payload as a string:
```bash
$ curl http://192.168.1.113:8080/function/gofunction -d 'Nic'
Hello, Go. You said: Nic
```

## Nomad Status
`nomad status`{{execute}}

## Other commands
Nomad CLI help menu: `nomad help`{{execute}}

Terraform CLI help menu: `terraform help`{{execute}}

## Git
Git is also installed in this playground, to clone a repository from GitHub you can use all of the standard git 
commands, for example:
`git clone https://github.com/hashicorp/terraform-container-deploy.git`
