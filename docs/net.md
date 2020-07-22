---
layout: default
---
- [home](/index.md)
- [ssh](/net-ssh.md)
---
# Networking
```
curl -v ipv4.icanhazip.com
curl -v -6 ipv6.icanhazip.com
```

# curl
```
curl -fsSL <url> | bash

```

# populate arp tables
```
nmap -T5 -n -sn x.x.x.0/24
```

# Vendor lookup from mac-addr
```
arp -a |cut -d' ' -f4 |grep -v incom|cut -c-8 |sort -u > mac-addrs
for i in $(cat mac-addrs ); do echo $i; curl https://api.macvendors.com/$i; echo; sleep 2; done
# grep and sort by IP
arp -a |awk '{print $4 " " $2}' |tr -d "\(\)" |sort -uk2 -V |grep 'xx:xx:xx'
```

# DNS flush
```
# apple
sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
```

# tcpdump
```
tcpdump -ni en0 'tcp[tcpflags] & (tcp-syn|tcp-fin) != 0'
tcpdump -i eno2 ether host 'xx:xx:xx:xx:xx:xx'
tcpdump -i eno2 ip host \( 1.2.3.4 or  4.3.2.1 \)
```

# routes
```
sudo route del default
sudo route add default gw 10.182.200.1 eth1
traceroute -n -w 1 10.182.200.100
```

# Connection tests
```
echo X | telnet -e X 192.168.1.135 3306
nc -v -z -w1 192.168.1.135 3306
nc -vz email-smtp.us-east-1.amazonaws.com 587 # 25, 465
```

# Linux listening Ports
```
ss -nlt
# which process listening
lsof -ni ':80'
```

# Get my IP
- http://checkip.amazonaws.com/
```
GETIPADDR="dig +short myip.opendns.com @resolver1.opendns.com"
```

### Monitoring tools
- darkstat
- iptraf
- iperf -P
