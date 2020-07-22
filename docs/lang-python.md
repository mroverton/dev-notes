---
layout: default
---
- [home](/index.md)
- [lang](/lang.md)
---
# Python Notes
## Docs
- https://docs.python.org/3.7/index.html
- [Python3 Tutorial](https://docs.python.org/3/tutorial/index.html)
- [Types](https://docs.python.org/3.7/library/stdtypes.html)
- [Standard Lib](https://docs.python.org/3.7/library/index.html)
- [TutorialsPoint](https://www.tutorialspoint.com/python/python_quick_guide.htm)

## Paths
```
print "\n".join(sys.path)
```
## get IP
```
hostname -I
python -c "import socket; s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM); s.connect(('8.8.8.8', 80)); print(s.getsockname()[0]); s.close()"
```

## Open
- https://docs.python.org/3/library/functions.html#open
- https://docs.python.org/2.7/library/functions.html#open
- https://docs.python.org/2.7/library/stdtypes.html#bltin-file-objects
```
# 3
with open('spamspam.txt', 'w', opener=opener) as f:
    print('This will be written to somedir/spamspam.txt', file=f)

# 2.7
with open("hello.txt") as f:
    for line in f:
        print line,

```
