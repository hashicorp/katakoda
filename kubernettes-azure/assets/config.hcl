section "title" {
  value = <<TITLE
This demo requires valid Azure credentials in order for Terraform
to be able to create resources, these values will only be stored
to environment varialbes and will not be persisted to disk
TITLE

}

section "input" {
  question = "Subscription ID:"
  env_var  = "TF_VAR_subscription_id"
}

section "input" {
  question = "Client ID:"
  env_var  = "TF_VAR_client_id"
}

section "input" {
  question = "Client Secret:"
  env_var  = "TF_VAR_client_secret"
	mask     = true
}

section "input" {
  question = "Tennant ID:"
  env_var  = "TF_VAR_tennant_id"
}

section "command" {
  title   = "Something"
  command = "ls"
	args = ["-ls"]
}
