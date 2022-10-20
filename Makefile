ifeq ($(TAG),)
TAG := 'latest'
endif

fetch-deps:
	./pull-repositories.sh

build-and-push-with-buildx: fetch-deps
#	docker buildx build --push --platform=linux/arm64,linux/amd64 --tag=amukas/repo1:$(TAG) \
#		-f ./Dockerfile .
	docker buildx build --push --platform=linux/amd64 --tag=amukas/repo1:$(TAG) \
		-f ./Dockerfile .

build: fetch-deps
	DOCKER_BUILDKIT=false docker build --tag=amukas/repo1:$(TAG) \
		-f ./Dockerfile . --no-cache
