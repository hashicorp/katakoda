Request another certificate and save the serial number a variable named
`CERT_SERIAL_NUMBER`.

```shell
CERT_SERIAL_NUMBER=$(vault write -format=json \
  pki_int/issue/example-dot-com \
  common_name="test.example.com" \
  ttl="24h" | jq -r ".data.serial_number")
```{{execute}}

Display the certificate serial number.

```shell
echo $CERT_SERIAL_NUMBER
```{{execute}}

Revoke the certificate with serial number `CERT_SERIAL_NUMBER`.

```shell
vault write pki_int/revoke serial_number=$CERT_SERIAL_NUMBER
```{{execute}}
