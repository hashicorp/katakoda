export NOMAD_ADDR=http://host01:4646
export FAAS_GATEWAY=https://[[HOST_SUBDOMAIN]]-8078-[[KATACODA_HOST]].environments.katacoda.com/
export DOCKER_REGISTRY=https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/v2

# Start Nomad
sleep 1; ~/launch.sh;

# Install templates
faas-cli template pull

#sleep 1; clear
: The Docker Registry URL is https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/v2
: The OpenFaaS Gateway is https://[[HOST_SUBDOMAIN]]-8078-[[KATACODA_HOST]].environments.katacoda.com/
