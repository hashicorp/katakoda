echo "Starting Nomad and OpenFaaS"
echo "Waiting for Nomad to start... This may take a couple of moments"
n=0
until [ $n -ge 10 ]
do
  response=`curl -sL -w "%{http_code}\\n" "http://host01:4646/v1/status/leader" -o /dev/null --connect-timeout 3 --max-time 5`
  if [[ "${response}" == "200" ]]; then
    echo "NOMAD Running"
    break
  fi

  n=$[$n+1]
  sleep 2
done
echo "Nomad started. "

echo -n "Configuring... "

# Download job files
curl -L -o ~/faas.hcl https://raw.githubusercontent.com/hashicorp/faas-nomad/master/nomad_job_files/faas.hcl &> /dev/null
#curl -L -o ~/monitoring.hcl https://raw.githubusercontent.com/hashicorp/faas-nomad/master/nomad_job_files/monitoring.hcl &> /dev/null

nomad run ~/faas.hcl &> /dev/null
echo "Nomad with OpenFaaS Ready"
