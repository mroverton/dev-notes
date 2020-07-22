---
layout: default
---
- [home](/index.md)
- [build](/build.md)
---

https://www.gnu.org/software/make/manual/make.html


[Pass arguments](https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line/6273809)
```
action:
        @echo action $(filter-out $@,$(MAKECMDGOALS))

%:      # thanks to chakrit
    @:    # thanks to William Pursell
```
