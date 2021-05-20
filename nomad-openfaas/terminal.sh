export NOMAD_ADDR=https://[[HOST_SUBDOMAIN]]-4646-[[KATACODA_HOST]].environments.katacoda.com
export CONSUL_HTTP_ADDR=http://host01:8500
export FAAS_GATEWAY=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
export DOCKER_REGISTRY_URL=https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/v2
export DOCKER_REGISTRY=[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com
export GOPATH=/home/scrapbook/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

mkdir -p /home/scrapbook/go/src/functions
cd /home/scrapbook/go/src/functions

# Echo status
: The local Docker Registry is [[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com
: The OpenFaaS Gateway is https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
