{{ with secret "pki_int/issue/consul-dc1" "common_name=server.dc1.consul" "ttl=2m"}}
{{ .Data.issuing_ca }}
{{ end }}