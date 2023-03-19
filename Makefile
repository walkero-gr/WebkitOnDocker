REPO ?= walkero/webkitondocker
TAG ?= 1.5
VOLUMES ?= -v "${PWD}/code":/opt/code
WORKSPACE ?= -w /opt/code
NAME ?= webkitondocker

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) .

buildnc:
	docker build --no-cache \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) .

shell:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
