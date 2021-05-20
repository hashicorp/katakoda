host01_commands=(
"curl -o ./install.sh https://raw.githubusercontent.com/hashicorp/katakoda/master/nomad-openfaas/assets/install.sh"
"chmod +x install.sh"
"./install.sh"
)

all_commands=$(awk -v sep=' && ' 'BEGIN{ORS=OFS="";for(i=1;i<ARGC;i++){print ARGV[i],ARGC-i-1?sep:""}}' "${host01_commands[@]}")

echo "$all_commands"

ssh root@host01 "$all_commands"




GOPATH=/home/scrapbook/go /usr/local/go/bin/go get -u github.com/golang/dep/cmd/dep
mkdir -p /home/scrapbook/go/src/functions

# Setup Docker registry
docker run -d --name registry -p 5000:5000 registry:2
