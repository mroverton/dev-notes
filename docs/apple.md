---
layout: default
---
- [home](/index.md)

---
# Apple Notes
- [brew](/apple-brew.md)
- [finder](/apple-finder.md)
- [MacOs](/apple-os.md)

## Send cli output to the clipboard
```
echo $VAL |pbcopy
pbcopy < ~/.ssh/id_rsa.pub
```

### Misc
```
ps auxww

# Full listing grep
pgrep -al search-string
```

# Apple MacOS Notes

```
sw_vers -productVersion
```


## DNS flush
```
# apple
sudo killall -HUP mDNSResponder
sudo killall mDNSResponderHelper
sudo dscacheutil -flushcache
```

### See dns detail

```
scutil --dns
```

### Development
- <https://cocoapods.org/>

```
gem install cocoapods
```

### Strace on macOS
```
# nope
dtruss -f su - myron -c 'cd /Users/myron/ws/ni/farm/repos/datamgmt && ./bin/console -e test doctrine:schema:create'

# yeah
# terminal one
echo $$

# terminal two
sudo dtruss -p 1154 -f
# back to terminal one
./bin/console -e test doctrine:schema:create
# terminal two has the trace
```
