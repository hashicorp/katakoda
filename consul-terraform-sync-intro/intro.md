# Network Interface Automation with Consul-Terraform-Sync

In this hands-on lab, you will deploy a Consul datacenter using Docker,
install Consul-Terraform-Sync, and use it to monitor changes in the service
catalog.


![NIA with Consul-Terraform-Sync](./assets/consul-nia-cts.png)


Specifically, you will:

- Check datacenter nodes and services
- Install Consul-Terraform-Sync
- Configure Consul-Terraform-Sync
- Inspect Consul-Terraform-Sync configuration
- Run Consul-Terraform-Sync
- Verify services data retrieved from Consul catalog
- Use the `/status` API to get information on task runs
- Change a service definition
- Verify Consul-Terraform-Sync intercepts the change