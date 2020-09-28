# Set the `CONSUL_HTTP_ADDR` environment variable.
export CONSUL_HTTP_ADDR=$(az hcs show \
                        --name $HCS_MANAGED_APP \
                        --resource-group $RESOURCE_GROUP \
                        | jq -r .properties.consulExternalEndpointUrl) && \
                        echo $CONSUL_HTTP_ADDR

# Set the `CONSUL_HTTP_TOKEN` environment variable to the bootstrap
# token to allow full command line access.
export CONSUL_HTTP_TOKEN=$(kubectl get secret \
                        $HCS_MANAGED_APP-bootstrap-token \
                        -o jsonpath={.data.token} | base64 -d) \
                        && echo $CONSUL_HTTP_TOKEN

sudo tee -a $HOME/.bashrc <<EOF
export CONSUL_HTTP_ADDR=$CONSUL_HTTP_ADDR
export CONSUL_HTTP_TOKEN=$CONSUL_HTTP_TOKEN
export CONSUL_HTTP_SSL_VERIFY=false
EOF