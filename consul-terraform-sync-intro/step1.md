The Consul-Terraform-Sync daemon comes packaged as a single binary. For this hands-on lab,
you are going download the tech beta and move the binary
into your path.

First, download the binary from the HashiCorp's [release website](https://releases.hashicorp.com).

`curl --silent https://releases.hashicorp.com/consul-terraform-sync/0.1.0/consul-terraform-sync_0.1.0_linux_amd64.zip -o consul-terraform-sync.zip`{{execute T1}}

Then, unzip the package.

`unzip consul-terraform-sync.zip`{{execute T1}}

Finally, move the binary on a location in your `PATH`.

`mv consul-terraform-sync /usr/local/bin/consul-terraform-sync`{{execute T1}}

### Verify installation

You can verify Consul-Terraform-Sync is installed by checking the version.

`consul-terraform-sync -version`{{execute T1}}

Or by exploring the help output.

`consul-terraform-sync -h`{{execute T1}}