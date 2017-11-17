export NOMAD_ADDR=http://host01:4646
for i in {1..20}; do ~/launch.sh && break || sleep 1; done
