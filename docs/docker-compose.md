- [[docker]]
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
