curl -L http://assets.joinscrapbook.com/unzip -o /usr/bin/unzip
chmod +x /usr/bin/unzip

curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.0.2/consul_1.0.2_linux_amd64.zip
curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip

unzip -d  /usr/bin/ ~/nomad.zip
unzip -d  /usr/bin/ ~/consul.zip

chmod +x  /usr/bin/nomad
chmod +x /usr/bin/consul

rm ~/nomad.zip ~/consul.zip

mkdir -p ~/log
# TODO: Is this the correct public IP address?
PUBLIC_IP=$(ip route get 1 | cut -d ' ' -f 7)
IF=$(ip route get 1 | head -n1 | cut -d ' ' -f 5)
nohup consul agent -dev -client="$PUBLIC_IP 127.0.0.1" -advertise=$PUBLIC_IP >~/log/consul.log 2>&1 &

nohup nomad agent -dev -network-interface=${IF} -bind=0.0.0.0 >~/log/nomad.log 2>&1 &
