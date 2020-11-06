{{ with secret "kv-v2/data/consul/config/encryption" }}
{{ .Data.data.key}}
{{ end }}
