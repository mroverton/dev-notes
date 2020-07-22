---
layout: default
---
- [home](/index.md)
- [tools](/tools.md)

---
# GIT Notes
- <https://git-scm.com/docs>

```
git fetch origin
git pull origin master
git branch -d -r origin/mro_config_apr08
git push origin :mro_config_apr08
git submodule update --init —recursive
git reset -q --hard 7f7dba1...20457159
git push -v --tags --set-upstream origin mro_replayer:mro_replayer
git checkout -b atalla_driver --track origin/atalla_driver
git submodule update --init --recursive

git log --decorate --all --oneline --graph
git log v1.3.0.17..v1.3.0.18 --decorate --all --oneline --graph

# commits with deletes
git log --summary --diff-filter=D

# protect against Windows line endings
git config --global core.autocrlf true

# What in the stage
git diff --staged

# What changed
git-all.rb \
-q log v1.3.0.17..v1.3.0.18 \
--pretty=format:'%ad -- %s' \
--date=format:'%Y-%m-%d %H:%M:%S' \
release/1.3.0 \
| egrep ^20 \
| sort -u

# BitBucket Rename
- Lock old repo in BitBucket
- Create new repo in BitBucket
git clone --bare old-ref
cd old
git lfs fetch --all # if large-file enabled
git push --mirror new-ref
git lfs push --all new-ref # if large-file enabled
# all git-sha are the same

# if you have checked out repo and no longer have access to remote repo...
cd old-repo
git push --prune \
  git@bitbucket.org:xxx/new-repo.git \
  +refs/remotes/origin/*:refs/heads/* \
  +refs/tags/*:refs/tags/*

# working on a feature...What repos need to merge?
ga fa
ga l ..origin/develop |t
```
# Delete tags
```
git tag -d tagname # local
git push -v origin :refs/tags/tagname  # remote
git push --delete origin YOUR_TAG_NAME # remote

# sync with remote
git tag -l | xargs git tag -d
git fetch --tags
```
## ~/.gitconfig
## aliases
```
[alias]
    a = add
    ac = commit -am
    b = branch
    ba = branch -a
    c = commit -m
    cf = config --global -e
    cfl = config --local -e
    config-edit = config --global -e
    co = checkout
    cp = cherry-pick
    ci = commit
    d = diff
    dn = diff --name-only
    f = fetch
    fa = fetch --all -p
    i = pull
    in = log ..@{u} --oneline
    ir = pull -r
    l = log --graph --pretty=format:'%C(cyan)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)' --abbrev-commit
    ll = log --graph --abbrev-commit --decorate --date=format:\"%Y-%m-%d %H:%M:%S\" --format=format:\"%ad %C(bold cyan)%h %s%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)\"
    la = log --graph --abbrev-commit --decorate --all --tags --format=format:\"%C(bold blue)%h%C(reset) - %C(bold cyan)%h %s%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)\"
    ln = log --name-status --oneline
    lt = log --format=\"%h (%an)%d - %s\" --decorate --graph
    lo = log --format=\"%h %s (%an) %ci %d\" --graph
    ls = ls-files
    ls0 = ls-files -z
    lsi = ls-files --others -i --exclude-standard
    lsu = ls-files -o --exclude-standard
    modified-files = ls-files -m
    m = merge
    mt = mergetool
    new = !gitk --all --not ORIG_HEAD
    o = push
    out = log @{u}.. --oneline
    r = reset HEAD
    ri = rebase -i
    rr = remote -v
    s = status
    si = status --ignored
    ss = status -s -b
    timeline = log --graph --branches --pretty=oneline --decorate
    mkbranch = "!f(){ git branch ${1} && git co ${1} && git push origin ${1} && git branch --set-upstream-to=remotes/origin/${1} ; };f"
    rmbranch = "!f(){ git branch -d ${1} ; git push origin --delete ${1}; };f"
```