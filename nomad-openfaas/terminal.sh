export NOMAD_ADDR=http://host01:4646

sleep 1; ~/launch.sh;

echo "Your local docker registry url is: https://$HOST-5000-ollie02.environments.katacoda.com/v2/"
