---
layout: default
---
- [home](/index.md)

# Shells
- [bash](/shell-bash.md)

---
# edit path on macOS
- /etc/paths
- /etc/paths.d # files with paths

## SED
```
# Linux
sed -i -e "s@<TOKEN>@${avar}@g" file.yaml
# macOS
sed -i "" -e "s@<TOKEN>@${avar}@g" file.yaml

# Solution
function sed_i {
   if test "$(uname)" == "Darwin"
   then
      sed -i '' "$@"
      return $?
   else
      sed -i "$@"
      return $?
   fi
}
```
