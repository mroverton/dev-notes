---
layout: default
---
- [home](/index.md)
- [linux](/linux.md)

---

- <https://wiki.debian.org/systemd/Services>

# Create a new Systemd Service
```
sudo -i
# --force creates new service
systemctl edit --force --full aname.service
```

# Generic example
```
[Unit]
Description=Be Home Service
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=15
ExecStart=/root/tunnel-service.sh

[Install]
WantedBy=multi-user.target
```

# one-shot example
```
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
systemctl edit --force --full aname.service
systemctl daemon-reload # after editing a file

systemctl enable servicename1
systemctl start servicename1
systemctl status servicename1
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
