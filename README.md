# ubuntu-init
### docker buildx create
```
docker buildx create --name mybuilder --use
```
### 단일 플랫폼으로 빌드 (로컬로 로드)
```
docker buildx build \
  --platform linux/amd64 \
  --tag anti1346/ubuntu-init:24.04 \
  --build-arg SSH_ROOT_PASSWORD=root \
  --no-cache --load .  
```
<details>
<summary>다중 플랫폼으로 빌드 후 Docker Hub에 푸시</summary>

### docker buildx build & push
```
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag anti1346/ubuntu-init:24.04 \
  --build-arg SSH_ROOT_PASSWORD=root \
  --no-cache --push .  
```
</details>

### docker inspect
```
docker inspect anti1346/ubuntu-init:24.04 --format='{{.Architecture}}'
```
```
docker inspect anti1346/ubuntu-init:latest --format='{{.Architecture}}'
```
### docker container run
```
docker run -it --rm --privileged --name ubuntu-init anti1346/ubuntu-init:24.04 /bin/bash
```

### entering a running docker container
```
docker exec -it ubuntu-init bash
```

<details>
<summary>원도우 빌드 및 실행</summary>

### 이미지를 빌드하고 태그를 지정
```
docker build -t anti1346/ubuntu-init:24.04 .
```
### 컨테이너를 백그라운드에서 실행
```
docker run -d --privileged --name ubuntu-init anti1346/ubuntu-init:24.04
```
### 이미지의 시스템 아키텍처를 확인
```
docker inspect anti1346/ubuntu-init:24.04 --format='{{.Architecture}}'
```
### 컨테이너에 bash 셸로 접속
```
docker exec -it ubuntu-init bash
```
</details>

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
