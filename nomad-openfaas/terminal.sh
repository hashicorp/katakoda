export NOMAD_ADDR=http://host01:4646

# Setup Docker registry
docker run -d -e VIRTUAL_HOST=registry.test.training.katacoda.com -v /opt/registry/data:/var/lib/registry --name registry registry:2

docker create -v /etc/nginx/certs --name nginx_certs busybox
docker cp /certs/registry.test.training.katacoda.com.crt nginx_certs:/etc/nginx/certs/
docker cp /certs/registry.test.training.katacoda.com.key nginx_certs:/etc/nginx/certs/

docker run -d -p 80:80 -p 443:443 --volumes-from nginx_certs -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx benhall/nginx-registry-proxy:1.9.6

sleep 1; ~/launch.sh;
