---
layout: default
---
- [home](/index.md)

---
# Tool Notes
- [GIT](/tools-git.md)
- [AWK](/tools-awk.md)
- [jq](/tools-jq.md)
- [yaml](/tools-yaml.md)
- [Apache Benchmarking](/tools-apache-bench.md)
- [ASDF-vm](/tools-asdf.md)

---
# tar
```
# Example of timestamp and multiple files.
tar -czvf nginx_$(date +'%F_%H-%M-%S').tar.gz nginx.conf sites-available/ sites-enabled/ nginxconfig.io/
```
# less
```
# Dont forget about -R when ascii color is involved.
someprocess |less -R

```
