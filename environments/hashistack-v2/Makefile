PROJECT="katacoda"

build: clean
	@echo "==> Building $(PROJECT) image..."
	@docker build \
        --rm \
        -t \
		$(PROJECT):latest \
        .
run: build
	@echo "==> Running $(PROJECT) container..."
	docker run \
	  -d \
	  --privileged \
	  --name \
	  $(PROJECT) \
	  $(PROJECT)
	@echo "==> Build complete, run command to continue:"
	@echo "==> docker exec -it $(PROJECT) bash"

clean:
	@echo "==> Resetting $(PROJECT) container..."
	docker ps -a | grep $(PROJECT) && docker rm -f $(PROJECT)

.DEFAULT_GOAL := run 

.PHONY: build
.IGNORE: clean
