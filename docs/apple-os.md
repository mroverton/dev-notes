---
layout: default
---
- [home](/index.md)
- [apple](/apple.md)
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

# brew unlink/link
```
brew unlink php && brew link --overwrite --force php@7.4

```
