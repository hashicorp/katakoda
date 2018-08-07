host_commands=(
"mkdir -p ~/src"
"cd ~/src && curl -L http://assets.joinscrapbook.com/unzip -o /usr/local/bin/unzip"
"chmod +x /usr/local/bin/unzip"

"cd ~/src && curl -L https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip -O"
"unzip -d /usr/local/bin ~/src/consul*.zip"

"cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -O"
"mv ~/src/counting-service /usr/local/bin"
"cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -O"
"mv ~/src/dashboard-service /usr/local/bin"
"chmod +x /usr/local/bin/*-service"

"useradd consul --create-home"
"mkdir -p /etc/consul.d"
"cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/counting.json -O"
"cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/dashboard.json -O"
"mkdir -p /home/consul/log"
"chown -R consul /home/consul"
"runuser -l consul -c \"consul agent -dev -client 0.0.0.0 -config-dir=/etc/consul.d >/home/consul/log/consul.log 2>&1 &\""
)

all_commands=$(awk -v sep=' && ' 'BEGIN{ORS=OFS="";for(i=1;i<ARGC;i++){print ARGV[i],ARGC-i-1?sep:""}}' "${host_commands[@]}")

echo "$all_commands"

ssh root@host01 "$all_commands"
