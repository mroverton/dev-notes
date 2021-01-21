---
layout: default
---
- [home](/index.md)
- [docker](/docker.md)
- [limit resources](https://docs.docker.com/compose/compose-file/compose-file-v3/#resources)

---
# Docker Compose Notes
```
alias dc=docker-compose
dc build
dc create
dc up # foreground
dc up -d # background
dc create --force-recreate --build [service-name]
dc logs -f --no-color |grep x|less
```
