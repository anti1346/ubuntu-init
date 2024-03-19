# ubuntu-init
### docker buildx create
```
docker buildx create --use
```
### docker buildx build & push
```
docker buildx build --platform linux/amd64,linux/arm64 --tag anti1346/ubuntu-init:latest --no-cache --push .
```

### docker inspect
```
docker inspect anti1346/ubuntu-init:latest --format='{{.Architecture}}'
```

### docker container run
```
docker run -itd --privileged --name ubuntu-init --hostname ubuntu-init anti1346/ubuntu-init:latest
```

### entering a running docker container
```
docker exec -it ubuntu-init bash
```

<details>
## docker build
```
docker build --tag anti1346/ubuntu-init:22.04 .
```

## docker tag change
```
docker image tag anti1346/ubuntu-init:22.04 anti1346/ubuntu-init:latest
```

## docker container run
```
docker run -d --privileged --name ubuntu-init --hostname ubuntu-init anti1346/ubuntu-init:latest /sbin/init
```

## entering a running docker container
```
docker exec -it ubuntu-init bash
```
</details>
