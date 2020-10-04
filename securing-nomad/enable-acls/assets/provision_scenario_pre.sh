if [ ! -f ~/tls_environment ]
then
echo "Additional scenario specific provisioning..."
if [ -d /opt/nomad/ca ]; then echo "Resetting TLS configuration"; rm -rf /opt/nomad/ca; fi

mkdir -p /opt/nomad/ca
cd /opt/nomad/ca
consul tls ca create -domain=nomad > /dev/null
consul tls cert create -domain=nomad -dc=global -server > /dev/null
consul tls cert create -domain=nomad -dc=global -client > /dev/null
mkdir -p /etc/nomad.d/tls
cp nomad-agent-ca.pem /etc/nomad.d/tls
cp global-server-nomad-0* /etc/nomad.d/tls
cp global-client-nomad-0* /etc/nomad.d/tls

for I in {1..3}; do
  sed "s/{{NODE}}/server$I/g" /tmp/server.hcl.template > /opt/nomad/server$I/nomad.hcl
  restart_server$I
done
sed "s/{{NODE}}/client/g" /tmp/client.hcl.template > /opt/nomad/client/nomad.hcl
restart_client

cat > ~/tls_environment <<EOF
echo "Preloading TLS Environment Variables..."
export NOMAD_CAPATH="/etc/nomad.d/tls/nomad-agent-ca.pem"
export NOMAD_CLIENT_CERT="/etc/nomad.d/tls/global-server-nomad-0.pem"
export NOMAD_CLIENT_KEY="/etc/nomad.d/tls/global-server-nomad-0-key.pem"
export NOMAD_ADDR="https://127.0.0.1:4646"
echo $ export NOMAD_CAPATH="/etc/nomad.d/tls/nomad-agent-ca.pem"
echo $ export NOMAD_CLIENT_CERT="/etc/nomad.d/tls/global-server-nomad-0.pem"
echo $ export NOMAD_CLIENT_KEY="/etc/nomad.d/tls/global-server-nomad-0-key.pem"
echo $ export NOMAD_ADDR="https://127.0.0.1:4646"
EOF

fi