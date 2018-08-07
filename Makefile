.PHONY: clean images

install:
	mkdir -p ~/bin
	curl -o ~/bin/pngquant.tar.bz2 https://pngquant.org/pngquant.tar.bz2
	cd ~/bin && tar xvzf ~/bin/pngquant.tar.bz2
	rm ~/bin/pngquant.tar.bz2

images:
	mkdir -p dist/images
	~/bin/pngquant --ext -web.png assets/images/*.png
	mv assets/images/*-web.png dist/images
	for f in dist/images/*; do mv "$$f" "`echo $$f | sed 's/-web\.png/\.png/g'`"; done

clean:
	rm -rf dist
