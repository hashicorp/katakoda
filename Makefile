.PHONY: clean images deploy

project_name = $(shell basename $(shell pwd))

# Install dependencies used by tasks in this Makefile
install:
	mkdir -p ~/bin
	curl -o ~/bin/pngquant.tar.bz2 https://pngquant.org/pngquant.tar.bz2
	cd ~/bin && tar xvzf ~/bin/pngquant.tar.bz2
	rm ~/bin/pngquant.tar.bz2
	brew install awscli

# Compress images for the web and store in `dist/images`
images:
	mkdir -p dist/images
	~/bin/pngquant --ext -web.png assets/images/*.png
	mv assets/images/*-web.png dist/images
	for f in dist/images/*; do mv "$$f" "`echo $$f | sed 's/-web\.png/\.png/g'`"; done

clean:
	rm -rf dist

# Copy images to S3
deploy:
	aws s3 sync --acl "public-read" dist/images s3://hashicorp-education/katacoda/$(project_name)/images

