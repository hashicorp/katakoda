variable "namespace" {
  default = "minecraftterraform"
}

variable "location" {
  default = "West US 2"
}

variable "subscription_id" {
  description = "Subscription ID for Azure account"
}

variable "client_id" {
  description = "Client ID for Azure account"
}

variable "client_secret" {
  description = "Client secret for Azure account"
}

variable "tenant_id" {
  description = "Tennant ID for Azure account"
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  default = "minecraftkube"
}
