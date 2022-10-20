## buildx

## docker multistage build

## running image built

```shell
docker run --name=<name> --rm <img>
```

or compose

## enter running container

```
docker exec -it <container-name> bash
```

## buildx and multiarch
https://github.com/docker/buildx
https://github.com/tonistiigi/binfmt

## gotchas

### 1: .dockerignore

### 2: running multiple apps in the same container

### 3: docker and compose caches

For compose use:
```
--build
```

For docker build:
```
--no-cache
```
