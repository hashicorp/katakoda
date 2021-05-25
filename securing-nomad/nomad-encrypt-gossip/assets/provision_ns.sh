#!/usr/bin/env bash

NumServers=3

## Borrowed with many thanks from Ciro S. Costa
## "Using network namespaces and a virtual switch to isolate servers"
## https://ops.tips/blog/using-network-namespaces-and-bridge-to-isolate-servers/
sysctl -w net.ipv4.ip_forward=1

ip link add name br1 type bridge
ip link set br1 up
ip addr add 192.168.1.10/24 brd + dev br1
iptables -A FORWARD -i ens3 -o br1 -j ACCEPT
iptables -A FORWARD -o ens3 -i br1 -j ACCEPT
iptables -A FORWARD -o br1 -i br1 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j MASQUERADE


ServerIndexRange=$(eval echo {1..$NumServers})
for I in $ServerIndexRange
do
  mkdir -p $dir/opt/nomad/server$I/{data,logs}
  mkdir -p $dir/etc/netns/server$I
  ln -s /opt/nomad/server$I/nomad.hcl server$I.hcl
done

mkdir -p $dir/opt/nomad/client/{data,logs}
ln -s /opt/nomad/client/nomad.hcl client.hcl

echo "Creating network environments..."

## Servers
for I in $ServerIndexRange
do
  echo " - server $I"
  ip netns add server$I
  ip link add veth$I type veth peer name br-veth$I
  ip link set veth$I netns server$I
  ip netns exec server$I ip addr add 192.168.1.1$I/24 dev veth$I
  ip link set br-veth$I up
  ip netns exec server$I ip link set lo up
  ip netns exec server$I ip link set veth$I up
  ip link set br-veth$I master br1
  ip netns exec server$I ip route add default via 192.168.1.10

  ## Nomad Stuff
  sed "s/{{NODE}}/server$I/g" /tmp/server.hcl.template > /opt/nomad/server$I/nomad.hcl
  echo "nameserver 8.8.8.8" > /etc/netns/server$I/resolv.conf
  cat << EOF > /usr/local/bin/server$I
#!/usr/bin/env bash

ip netns exec server$I /bin/bash --rcfile <(cat ~/.bashrc; echo "cd /opt/nomad/server$I"; echo 'PS1="\$(ip netns identify) > "')
EOF

  cat << EOF > /usr/local/bin/stop_server$I
#!/usr/bin/env bash

SERVER_PID=\$(ps aux | grep nomad | awk "/server$I/ {print \\\$2}")

if [ "\$SERVER_PID" != "" ]
then
  ip netns exec server$I kill \$SERVER_PID
  echo "Stopped PID \$SERVER_PID"
else
  echo "No running PID found for Server $I"
fi
EOF

  cat << EOF > /usr/local/bin/start_server$I
#!/usr/bin/env bash
echo -n "Starting server $I..."
ip netns exec server$I nohup nomad agent -config=/opt/nomad/server$I/nomad.hcl >> /opt/nomad/server$I/logs/nomad.log 2>&1 </dev/null &

if [ "\$?" ]
then
  echo "Started Server $I"
else
  echo "Received non-zero exit code (\$?) on start of Server $I."
fi
EOF

  cat << EOF > /usr/local/bin/restart_server$I
#!/usr/bin/env bash

stop_server$I
start_server$I
EOF

  chmod +x /usr/local/bin/*server*
  start_server$I

done

## client
## has to be the non-namespaced host because docker magic
  echo " - client"

  ## Nomad Stuff
  sed "s/{{NODE}}/client/g" /tmp/client.hcl.template > /opt/nomad/client/nomad.hcl


  cat << EOF > /usr/local/bin/stop_client
#!/usr/bin/env bash

client_PID=\$(ps aux | grep nomad | awk "/client/ {print \\\$2}")

if [ "\$client_PID" != "" ]
then
  kill \$client_PID
  echo "Stopped PID \$client_PID"
else
  echo "No running PID found for client."
fi
EOF

  cat << EOF > /usr/local/bin/start_client
#!/usr/bin/env bash
echo -n "Starting client..."
nohup nomad agent -config=/opt/nomad/client/nomad.hcl >> /opt/nomad/client/logs/nomad.log 2>&1 </dev/null &
if [ "\$?" ]
then
  echo "Started client."
else
  echo "Received non-zero exit code (\$?) on start of client."
fi
EOF

  cat << EOF > /usr/local/bin/restart_client
#!/usr/bin/env bash

stop_client
start_client
EOF

  chmod +x /usr/local/bin/*client*
  start_client

cat << EOF > /usr/local/bin/reset.sh
killall nomad
for I in {1..$NumServers}
do
  ip link del br-veth\$I
  ip netns del server\$I
done
ip link del dev br1
iptables -t nat -D POSTROUTING -s 192.168.1.0/24 -j MASQUERADE
EOF

chmod +x /usr/local/bin/reset.sh

echo "Finished."