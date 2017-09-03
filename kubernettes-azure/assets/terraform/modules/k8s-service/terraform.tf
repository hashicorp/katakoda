provider "kubernetes" {
  host       = "https://${var.k8s_master}"
}
