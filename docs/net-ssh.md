---
layout: default
---
- [home](/index.md)
- [net](/net.md)

---
# SSH Notes

```
# agent
ssh-add -L
ssh-add ~/.ssh/key.pem
ssh -A ... or add ForwardAgent yes to ~/.ssh/config

# gen a new key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# gen a new key to a file
ssh-keygen -f ~/.ssh/myfile.pem

# get public key from pem file
ssh-keygen -y -f myprod.pem |pbcopy

```

## SSH Config file snipets
```
Host host-beyond-bastion
    HostName 10.x.x.x
    User ec2-user
    IdentityFile ~/.ssh/EngProd-Admin.pem
    ProxyCommand ssh bastion -W %h:%p -q
# ----------
Host a alias list # valid for ssh, scp, rsync and others
    HostName fqdn or IP
    User ubuntu # ec2-user on redhat
    IdentityFile ~/.ssh/my-key.pem

# ----------
# AWS IP Defaults
Host 52.* 50.* 54.* 35.* 34.* 107.*
    User ubuntu
    #User ec2-user
    IdentityFile ~/.ssh/aws-key.pem
# ----------
# All hosts 
Host *
    AddressFamily inet
    Protocol 2
    Compression yes
    ServerAliveInterval 30
    TCPKeepAlive yes
```

## AWS code-commit 
```
# .ssh/config snipet
# 
Host aa
     HostName x.x.x.x
     User ubuntu
     IdentityFile ~/.ssh/mykey.pem

Host git-codecommit.*.amazonaws.com
  User xxx
  IdentityFile ~/.ssh/aws_key

# End


```

## Tunneling

### remote x11 process
`ssh -X 10.190.251.79 -t sudo su - bbbuser -c jconsole`

### mongo
```
ssh -vnNT -L localhost:27019:10.1.4.16:27017 mongo-prod # -f to bg

export TARGET_IP=
ssh -vnNT -L localhost:8080:$TARGET_IP:80 u@gw
```

### Reverse
- Install user pub key to authorized_keys on target
```
ssh-keygen -y -f user.pem |pbcopy
cat >> .ssh/authorized_keys
(paste and ctrl-d)
```

- Reverse from target to proxy host
```
ssh -nNT -R 19999:localhost:22 r-proxy
# bind to external interface. requires modification to server. see below.
ssh -vnNT -R \*:8080:localhost:8080 u 
```

- Login from proxy
```
ssh -p 19999 -i user.pem user@localhost
```

- If you need to enable binding for external access
```
sudo -i
vi /etc/ssh/sshd_config
# Allow reverse proxy to bind to 0.0.0.0
GatewayPorts yes
service sshd restart # does not affect current connections
```

- If backgrounded, you can find the process with
```
ps -elf |grep ssh
```

# Append a key to remote server
```
cat pub_key |ssh <name|ip> '(echo; cat -) >> .ssh/authorized_keys' # echo insures newline but seems to workout
```

# Add sudo to rsync priv
```
rsync -avC --rsync-path="sudo rsync" dfe-root:/etc ./
```

# VSCode with elevated privs
- <https://github.com/microsoft/vscode/issues/48659>

```
sed -i s/"-o RemoteCommand=none"/""/ ~/.vscode/extensions/ms-vscode-remote.remote-ssh-*/out/extension.js
sed -i s/"bash"/""/ ~/.vscode/extensions/ms-vscode-remote.remote-ssh-*/out/extension.js

# ~/.ssh/config sample
Host pi-for-newuser
  Hostname pi
  User pi
  RemoteCommand sudo -u newuser -i
```
