IMAGE_NAME = dotfiles
DOCKER_FILE = Dockerfile
USER_NAME = $(shell whoami)
USER_ID = $(shell id -u)
GROUP_ID = $(shell id -g)
TZ = Australia/Adelaide
HOST_DIR = $(shell pwd)

all: run

build:
	docker build \
		--build-arg USER_NAME=$(USER_NAME) \
		--build-arg USER_ID=$(USER_ID) \
		--build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg TZ=$(TZ) \
		-t $(IMAGE_NAME) -f $(DOCKER_FILE) .

run:
	docker run -it --rm --name $(IMAGE_NAME) -v $(HOST_DIR):/home/$(USER_NAME)/mnt $(IMAGE_NAME)

.PHONY: all build
