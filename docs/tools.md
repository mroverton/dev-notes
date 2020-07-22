- [[home]]

- [[GIT|tools-git]]
- [[AWK|tools-awk]]
- [[jq|tools-jq]]
- [[yaml|tools-yaml]]
- [[Apache Benchmarking|tools apache bench]]
- [[ASDF|tools asdf]]
---
# tar
```
# Example of timestamp and multiple files.
tar -czvf nginx_$(date +'%F_%H-%M-%S').tar.gz nginx.conf sites-available/ sites-enabled/ nginxconfig.io/
```
