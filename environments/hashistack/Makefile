PROJECT="katacoda"

build: clean
	@echo "==> Building katacoda image..."
	@docker build \
        --rm \
        -t \
		$(PROJECT):latest \
        .
run: build
	@echo "==> Running katacoda container..."
	docker run \
	  -d \
	  --cap-add=IPC_LOCK \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  --name \
	  $(PROJECT) \
	  $(PROJECT)
	@echo "==> Build complete, run command to continue:"
	@echo "==> docker exec -it $(PROJECT) bash"

clean:
	@echo "==> Restting kayakoda container..."
	docker ps | grep $(PROJECT) && docker rm -f $(PROJECT)
	docker kill $(PROJECT)
	docker rm -f $(PROJECT)


.DEFAULT_GOAL := run 

.PHONY: build
.IGNORE: clean
