---
layout: default
---
- [home](/index.md)
- [tools](/tools.md)
---
# Use templates
```
defaults: &defaults
  item: value

default-more: &defaults-more
  <<: *defaults
  item: override

use-em:
  <<: *defaults-more
  another: val
```


https://www.json2yaml.com/

