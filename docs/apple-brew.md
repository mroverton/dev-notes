---
layout: default
---
- [home](/index.md)
- [apple](/apple.md)
---
# brew
```
brew upgrade
brew cask upgrade
brew info --installed <item>
brew update && brew upgrade && brew cleanup && brew doctor
```
## List Deps
```
brew list | while read cask; do echo -n "$cask -> "; brew deps $cask | awk '{printf(" %s ", $0)}'; echo ""; done
```

- [Setup macOS for web](https://medium.freecodecamp.org/how-to-set-up-your-mac-for-web-development-b40bebc0cac3)
