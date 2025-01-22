# ubuntu-init
### docker buildx create
```
docker buildx create --name mybuilder --use
```
### docker buildx build & load
```
docker buildx build --platform linux/amd64,linux/arm64 --tag anti1346/ubuntu-init:latest --no-cache --load .
```

<details>
<summary>docker build & push</summary>
### docker buildx build & push
```
docker buildx build --platform linux/amd64,linux/arm64 --tag anti1346/ubuntu-init:latest --no-cache --push .
```
</details>

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
<summary>docker build</summary>

### docker build
```
docker build --tag anti1346/ubuntu-init:amd64 .
```
### docker tag change
```
docker image tag anti1346/ubuntu-init:amd64 anti1346/ubuntu-init:22.04
```
### docker pull
```
docker pull anti1346/ubuntu-init:22.04
```
### docker container run
```
docker run -d --privileged --name ubuntu-init --hostname ubuntu-init anti1346/ubuntu-init:22.04 /sbin/init
```
### entering a running docker container
```
docker exec -it ubuntu-init bash
```

</details>
