{{ with secret "kv-v1/consul/config/encryption" }}
{{ .Data.key}}
{{ end }}