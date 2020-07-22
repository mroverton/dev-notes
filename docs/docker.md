---
layout: default
---
- [home](/index.md)

---
# Docker Notes

https://docs.docker.com/

https://docs.docker.com/reference/

https://hub.docker.com/

[[Docker-Compose]]

## My Aliases
```
alias d=docker
alias dc=docker-compose
```


## Tips
```
d exec -it <container> bash # login to running container
d run --rm -it <image> bash # Run image in image. Use 'd ps -a' to see last failed build
---------------------------------------
watch -n2 docker-compose ps

---------------------------------------
# docker stats
docker stats --no-stream $(docker ps --format {{.Names}}) 
# runs once. Remove --no-stream to run continuously
---------------------------------------
# check resources
docker system df

# List
docker ps -q -f 'status=exited'
docker images -q -f "dangling=true"
docker volume ls -qf dangling=true

# cleanup
docker rm $(docker ps -q -f 'status=exited')
docker rmi $(docker images -q -f "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)

# remove none images https://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/
docker image prune --filter "dangling=true"

# dead process remover
docker images |grep ' '   |awk '{print $3}' |sort -u |xargs -n 1 docker rmi
docker images |egrep '^7' |awk '{print $3}' |sort -u |xargs docker rmi # remove ECR images
docker images |egrep '^7' |grep -v 1.2.0.36 |awk '{print $3}'|sort -u |xargs docker rmi
docker images |egrep '^7' |egrep -v '1.2.0.36|1.3.0-SNAPSHOT|latest' |awk '{print $3}'|sort -u |xargs docker rmi

docker images |egrep '^7' |awk '{print $2}' |sort -u
docker images |egrep '^7' |grep 1.2.0.36 |awk '{print $3}'|sort -u |xargs docker rmi

# ecr tokens in ~/.docker/config.json

# health
docker inspect --format='{{json .State.Health}}' $(dc ps -q svcname) |jq .
```

## Accessing Docker VM
https://gist.github.com/BretFisher/5e1a0c7bcca4c735e716abf62afad389
```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty

docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n sh
docker run -it --rm --privileged --pid=host justincormack/nsenter1
```

- [Elastic Doc](https://www.elastic.co/guide/en/elasticsearch/reference/7.8/docker.html) has
```
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
```
- `Ctrl a d` to exit


## Setup
```
grep vm.max_map_count /etc/sysctl.conf
vm.max_map_count=262144

sysctl -w vm.max_map_count=262144 # tmp. Set in /etc/sysctl.conf file.
```
## disk usage inside container

`docker run --rm alpine df -h`

## Service IP
`docker inspect --format '{{ .NetworkSettings.IPAddress }}' c1`