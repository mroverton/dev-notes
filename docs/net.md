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
sudo killall -HUP mDNSResponder
sudo killall mDNSResponderHelper
sudo dscacheutil -flushcache
```

# tcpdump
```
# syn/fin
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
- <http://checkip.amazonaws.com/>
```
GETIPADDR="dig +short myip.opendns.com @resolver1.opendns.com"
```

### Monitoring tools
- darkstat
- iptraf
- iperf -P

# MacOS
## vNIC
```
sudo -i
ifconfig vlan11 create
ifconfig vlan22 create
ifconfig vlan11 vlan 11 vlandev en1
ifconfig vlan22 vlan 22 vlandev en1
ifconfig vlan11 inet 10.10.11.11 netmask 255.255.255.255
ifconfig vlan22 inet 10.10.22.22 netmask 255.255.255.255

ifconfig vlan11 destroy
ifconfig vlan22 destroy
```

## DNSmasq
- source https://zhimin-wen.medium.com/setup-local-dns-server-on-macbook-82ad22e76f2a
```
brew install dnsmasq
cp /usr/local/etc/dnsmasq.conf /usr/local/etc/dnsmasq.conf.orig
echo "conf-dir=/usr/local/etc/dnsmasq.d/,*.conf" | tee /usr/local/etc/dnsmasq.conf
cat > /usr/local/etc/dnsmasq.d/mylocal.conf <<EOF
address=/host1.io.local/192.168.20.21
address=/host2.io.local/192.168.20.22
address=/.samplenet.io.local/192.168.20.21
EOF

sudo mkdir -p /etc/resolver

cat > /etc/resolver/io.local <<EOF
nameserver 127.0.0.1
EOF

sudo brew services start dnsmasq

#dnsmasq direct test
dig host1.io.local @localhost +short
192.168.20.21
dig anyname.io.local @localhost +short
192.168.20.21

# see dns detail
scutil --dns

# flush dns
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder


```
