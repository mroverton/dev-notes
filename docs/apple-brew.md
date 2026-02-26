---
layout: default
---
- [home](/index.md)
- [apple](/apple.md)

---
# Apple brew Notes
```
brew upgrade
brew cask upgrade
brew info --installed <item>
brew update && brew upgrade && brew cleanup && brew doctor

brew ls -l
```

## MAC Applications
```
mas list

# utils to list packages
ls /Applications
brew list
mas list # brew install mac apple store cli
pkgutil --pkgs
system_profiler SPApplicationsDataType
```

# Services
```
brew tap homebrew/services
sudo brew services start dnsmasq
sudo brew services info dnsmasq
brew services list
```

## List Deps
```
brew list | while read cask; do echo -n "$cask -> "; brew deps $cask | awk '{printf(" %s ", $0)}'; echo ""; done
```

## Change links
```
brew unlink postgresql@14
brew link postgresql@17

brew unlink mssql-tools
brew link --overwrite mssql-tools18
brew link --overwrite --dry-run mssql-tools18

# But the driver needs 1.1
brew install openssl@1.1
# you might need to delete the old symlink first
rm /usr/local/opt/openssl
# source dir might be slightly diff. Check with ls -l /usr/local/Cellar/openssl*
ln -s /usr/local/Cellar/openssl@1.1/1.1.1l /usr/local/opt/openssl

```

- [Setup macOS for web](https://medium.freecodecamp.org/how-to-set-up-your-mac-for-web-development-b40bebc0cac3)
