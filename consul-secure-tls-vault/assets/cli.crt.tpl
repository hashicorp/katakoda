{{ with secret "pki_int/issue/consul-dc1" "common_name=cli.dc1.consul" "alt_names=localhost" "ip_sans=127.0.0.1" "ttl=2m" }}
{{ .Data.certificate }}
{{ end }}