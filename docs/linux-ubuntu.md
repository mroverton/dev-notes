- [home](/)
- [linux](/linux.md)
---
# Ubuntu Notes

## apt notes
```
apt-get install --no-install-recommends --no-install-suggests -y a b c
```

## Add swap
```
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

EDITOR=vi vi /etc/fstab
/swapfile   none    swap    sw    0   0
```

## Time Setup NTP
```
echo "America/Denver" > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

https://aws.amazon.com/premiumsupport/knowledge-center/system-clock-drift-ubuntu/
server 0.amazon.pool.ntp.org
server 1.amazon.pool.ntp.org
server 2.amazon.pool.ntp.org
server 3.amazon.pool.ntp.org
timedatectl

ntpq -p

service ntp restart
```

```
lsb_release -a
rm -rf /var/lib/apt/lists/* # apt cleanup
apt list --upgradable

lsof -ni:80 # process listening on port 80
```
## netstat
```
# ss - new (ubuntu only?)
ss -nlt # tcp listening
```

# top package
```
apt install procps-ng
```
