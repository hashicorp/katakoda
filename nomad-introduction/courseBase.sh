curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip
chmod +x ~/.bin/unzip

curl -L -o ~/consul.zip https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
unzip -d  ~/.bin/ ~/consul.zip
chmod +x ~/.bin/consul

curl -L -o ~/nomad.zip https://releases.hashicorp.com/nomad/0.8.4/nomad_0.8.4_linux_amd64.zip
unzip -d  ~/.bin/ ~/nomad.zip
chmod +x  ~/.bin/nomad

rm ~/nomad.zip ~/consul.zip

export NOMAD_ADDR="http://host01:4646"

host01_commands=(
"curl --location https://raw.githubusercontent.com/hashicorp/katakoda/master/nomad-introduction/assets/host01_install.sh --remote-name"
"sh host01_install.sh"
)

all_commands=$(awk -v sep=' && ' 'BEGIN{ORS=OFS="";for(i=1;i<ARGC;i++){print ARGV[i],ARGC-i-1?sep:""}}' "${host01_commands[@]}")

echo "$all_commands"
ssh root@host01 "$all_commands"
