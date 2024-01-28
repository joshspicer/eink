# Variables
SERVER = http://localhost:3000

# Targets
all: build run

# -- Tooling

build:
	docker build ./server -t eink

run:
	docker run --rm --name eink --env-file .env -p 3000:3000 eink

inspect:
	docker exec -it eink bash

# -- Generators

newspaper:
	curl -X PATCH -d '{\"data1\": \"hello there it is me josh\"}' $(SERVER)/update?mode=newspaper

recipe:
	curl -X PATCH -d '{\"mealQuery\": \"palak\"}' $(SERVER)/update?mode=recipe

image:
	curl -X PATCH -d '{\"url\": \"https://joshspicer.com/assets/me/7.jpg\"}' $(SERVER)/update?mode=image

# -- View image.bmp in $BROWSER

view:
	xdg-open $(SERVER)/image.bmp

clean:
	docker rm eink -f
	docker image prune
