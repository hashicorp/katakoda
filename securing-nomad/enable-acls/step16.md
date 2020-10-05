With the app-dev token still active, try to use the Nodes API to list out the
Nomad clients in the cluster. Note that we have to provide all of the certificate
information to the `curl` command so that it will make a mTLS connection.  Also,
recall that we have the NOMAD_ADDR set to "https://127.0.0.1:4646" so that the
CLI will work properly.

```
curl --cert ${NOMAD_CLIENT_CERT} \
  --key ${NOMAD_CLIENT_KEY} \
  --cacert ${NOMAD_CACERT} \
  --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
  ${NOMAD_ADDR}/v1/nodes
```{{execute}}

**Example Output**

```
$ curl --cert ${NOMAD_CLIENT_CERT} \
  --key ${NOMAD_CLIENT_KEY} \
  --cacert ${NOMAD_CACERT} \
  --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
  ${NOMAD_ADDR}/v1/nodes
Permission denied
```

Set the active token to your test prod-ops token.

```
export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' prod-ops.token)
```{{execute}}

Resubmit your Nodes API query. Expect to have a significant amount of JSON
returned to your screen which indicates a successful API call.

```
curl --cert ${NOMAD_CLIENT_CERT} \
  --key ${NOMAD_CLIENT_KEY} \
  --cacert ${NOMAD_CACERT} \
  --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
  ${NOMAD_ADDR}/v1/nodes
```{{execute}}

**Example Output**

```
$ curl --cert ${NOMAD_CLIENT_CERT} \
  --key ${NOMAD_CLIENT_KEY} \
  --cacert ${NOMAD_CACERT} \
  --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
  ${NOMAD_ADDR}/v1/nodes

[{"Address":"172.17.0.21","ID":"ea6a87a7-4d23-b43a-2a7b-eb5cce62f853",
... response trimmed ... ]
```
