output "quake_client" {
  value = "${kubernetes_service.quake.load_balancer_ingress.0.ip}"
}

