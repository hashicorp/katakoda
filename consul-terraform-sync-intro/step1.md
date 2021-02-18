Consul-Terraform-Sync comes packaged as a single binary. For this hands-on lab
we are going to use the tech preview release since it is not been released.

First, download the binary from the HashiCorp's [release website](https://releases.hashicorp.com):

`curl --silent https://releases.hashicorp.com/consul-terraform-sync/0.1.0-techpreview2/consul-terraform-sync_0.1.0-techpreview2_linux_amd64.zip -o consul-terraform-sync.zip`{{execute T1}}

then, unzip the package:

`unzip consul-terraform-sync.zip`{{execute T1}}

finally, move the binary on a location in your `PATH`:

`mv consul-terraform-sync /usr/local/bin/consul-terraform-sync`{{execute T1}}

### Verify installation

You can verify Consul-Terraform-Sync is installed by checking the version:

`consul-terraform-sync -version`{{execute T1}}

or by exploring the help output

`consul-terraform-sync -h`{{execute T1}}