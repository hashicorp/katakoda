disable_mlock = true
ui=true

storage "file" {
  path = "~/vault-2/data"
}

listener "tcp" {
  address     = "0.0.0.0:8100"
  tls_disable = 1
}

seal "transit" {
  address = "http://127.0.0.1:8200"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "transit/"
  tls_skip_verify = "true"
}
