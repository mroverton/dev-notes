---
layout: default
---
- [home](/index.md)

---
# Apple MacOS Notes

```
sw_vers -productVersion
```


# DNS flush
```
# apple
sudo killall -HUP mDNSResponder
sudo killall mDNSResponderHelper
sudo dscacheutil -flushcache
```

## see dns detail

```
scutil --dns
```
