log_level = "trace"
ui        = true

storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

telemetry {
  dogstatsd_addr                 = "10.42.10.101:8125"
  enable_hostname_label          = true
  disable_hostname               = true
  enable_high_cardinality_labels = "*"
}
