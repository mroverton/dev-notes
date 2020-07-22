---
layout: default
---
- [home](/index.md)
- [linux](/linux.md)

---
# systemd
```
sudo vim /etc/systemd/system/disable-transparent-huge-pages.service

[Unit]
Description=Disable Transparent Huge Pages

[Service]
Type=oneshot
ExecStart=/bin/sh -c "/usr/bin/echo "never" | tee /sys/kernel/mm/transparent_hugepage/enabled"
ExecStart=/bin/sh -c "/usr/bin/echo "never" | tee /sys/kernel/mm/transparent_hugepage/defrag"

[Install]
WantedBy=multi-user.target
```
## Commands
```
systemctl enable disable-transparent-huge-pages
systemctl start disable-transparent-huge-pages
systemctl status disable-transparent-huge-pages
systemctl daemon-reload # after editing a file

systemctl daemon-reload
```

## Edit
```
sudo systemctl edit --full atlantis.service

[Unit]
Description=My Server
Requires=network.target
After=syslog.target network.target
[Service]
Type=simple
ExecStart=/home/x/bin/x serve \
--var-url="https://x.domain.net"
User=user1
[Install]
WantedBy=multi-user.target

```
