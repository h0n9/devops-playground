IMG_REGISTRY=docker.io
IMG_REPOSITORY=h0n9
IMG_NAME=devops-playround
IMG_TAG=0.0.1
IMG_TAG_DEV=dev
IMG=$(IMG_REGISTRY)/$(IMG_REPOSITORY)/$(IMG_NAME):$(IMG_TAG)
IMG_DEV=$(IMG_REGISTRY)/$(IMG_REPOSITORY)/$(IMG_NAME):$(IMG_TAG_DEV)

CONTAINER_NAME=devops-playground
CONTAINER_PORT=7780
CONTAINER_JAVA_OPTS=-Dlogging.level.org.springframework=DEBUG
CONTAINER_OPTS=-it --rm -e JAVA_OPTS=$(CONTAINER_JAVA_OPTS) -p $(CONTAINER_PORT):8080 --cpus 1.5 --name $(CONTAINER_NAME)

.PHONY: build build-prd push push-prd run run-prd 

build:
	docker build -t $(IMG_DEV) .
build-prd:
	docker build -t $(IMG) .
push:
	docker push $(IMG_DEV)
push-prd:
	docker push $(IMG)
run:
	docker run -e TARGET=dev $(CONTAINER_OPTS) $(IMG_DEV)
run-prd:
	docker run -e TARGET=prd $(CONTAINER_OPTS) $(IMG)
