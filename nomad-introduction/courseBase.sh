curl -L http://assets.joinscrapbook.com/unzip -o ~/.bin/unzip && chmod +x ~/.bin/unzip
curl -L -o ~/.bin/consul.zip https://releases.hashicorp.com/consul/0.9.0/consul_0.9.0_linux_amd64.zip
unzip -d ~/.bin ~/.bin/consul.zip && chmod +x ~/.bin/consul
curl -L -o ~/.bin/nomad.zip https://releases.hashicorp.com/nomad/0.6.0/nomad_0.6.0_linux_amd64.zip
unzip -d ~/.bin ~/.bin/nomad.zip && chmod +x ~/.bin/nomad
nohup ~/.bin/consul agent -dev >/dev/null 2>&1 &
nohup ~/.bin/nomad agent -dev >/dev/null 2>&1 &
