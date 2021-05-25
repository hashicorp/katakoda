Here is a place where you can do some creative play.

Here are some handy shortcuts that can help you while you explore the scenario
environment.

**Node Management**

`start_server1`{{execute}}
`start_server2`{{execute}}
`start_server3`{{execute}}
`start_client`{{execute}}

`stop_server1`{{execute}}
`stop_server2`{{execute}}
`stop_server3`{{execute}}
`stop_client`{{execute}}

`restart_server2`{{execute}}
`restart_server1`{{execute}}
`restart_server3`{{execute}}
`restart_client`{{execute}}


**Tokens to Environment**

`export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' bootstrap.token)`{{execute}}
`export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' app-dev.token)`{{execute}}
`export NOMAD_TOKEN=$(awk '/Secret/ {print $4}' prod-ops.token)`{{execute}}

**cURL commands for TLS**

`
curl --cert ${NOMAD_CLIENT_CERT} \
  --key ${NOMAD_CLIENT_KEY} \
  --cacert ${NOMAD_CAPATH} \
  --header "X-Nomad-Token: ${NOMAD_TOKEN}" \
  ${NOMAD_ADDR}/v1/nodes
`{{execute}}

You can also simplify this for repeat use by using an environment variable to 
hold your curl options.

`export CURL_OPTS="--cert ${NOMAD_CLIENT_CERT} --key ${NOMAD_CLIENT_KEY} --cacert ${NOMAD_CAPATH} --header \"X-Nomad-Token: ${NOMAD_TOKEN}\""`{{execute}}
`curl ${CURL_OPTS} ${NOMAD_ADDR}/v1/nodes`{{execute}}
