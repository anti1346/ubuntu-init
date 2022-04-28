# ubuntu-init

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