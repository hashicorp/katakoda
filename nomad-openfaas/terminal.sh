export NOMAD_ADDR=http://host01:4646

# Start Nomad
sleep 1; ~/launch.sh;

echo "DOCKER REGISTRY URL: https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/v2"
echo "OpenFaaS GATEWAY: https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/"
