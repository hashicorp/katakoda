This tutorial demonstrate the Boundary installation on Ubuntu. For other operating systems, refer to the [Install Boundary](https://learn.hashicorp.com/tutorials/boundary/getting-started-install) tutorial.


First, add the HashiCorp GPG key.

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```{{execute}}


Add the official HashiCorp Linux repository.

```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```{{execute}}

Finally, update and install Boundary.

```
sudo apt-get update && sudo apt-get install boundary
```{{execute}}

**That's it!**

Execute the following command to verify the boundary version.

```
boundary help
```{{execute}}
