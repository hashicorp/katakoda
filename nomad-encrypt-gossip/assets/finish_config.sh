#!/usr/bin/env bash

## finish_config.sh
for I in {2..3}
do
  sed "s/{{NODE}}/server$I/g" /tmp/server.hcl.complete.template > /opt/nomad/server$I/nomad.hcl
done

echo "Server2 and Server3 configurations updated"
