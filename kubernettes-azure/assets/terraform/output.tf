output "resource_group_id" {
  value = "${module.resource_group.id}"
}

output "resource_group_name" {
  value = "${module.resource_group.name}"
}

output "k8s_master" {
  value = "${module.container_service.master_fqdn}"
}

output "k8s_master_name" {
  value = "${var.k8s_cluster_name}"
}
