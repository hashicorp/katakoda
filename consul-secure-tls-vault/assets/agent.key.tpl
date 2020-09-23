{{ with secret "pki_int/issue/consul-dc1" "common_name=server.dc1.consul" "ttl=2m" "alt_names=localhost" "ip_sans=127.0.0.1"}}
{{ .Data.private_key }}
{{ end }}