- [home](/index.md)
- [bash](/shell-bash.md)
- [bashrc](/shell-bash-bashrc.md)
---
```
alias ,,a='set-aws-creds.sh'

# change directory aliases
alias ,c='cd ~/ws/code'
alias ,cc='cd ~/ws/code-2'

# alias a=aws
alias a=asdf
[ -n "$(typeset -f _asdf)" ] && complete -F _asdf a

alias b='mvn clean install'
alias be='bundle exec'
alias bi='./mvnw clean install'
alias Bi='mvn clean install'
alias bni='./mvnw -Dmaven.test.skip=true clean install'
alias Bni='mvn -Dmaven.test.skip=true clean install'
alias bnio='mvn -o -Dmaven.test.skip=true clean package'
alias bo='mvn install -Dmaven.test.skip -pl !skipthis-web -o'
alias bt='mvn clean test'

alias c=code-insiders

alias d=docker
alias d.screen='screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty'
alias dc=docker-compose
function dc.l () { while true; do docker-compose logs -f --tail=0; echo 'sleep 2'; sleep 2; done; }
alias dc.p='docker-compose --file ./docker-compose-prod.yml '
alias ddi='pushd >/dev/null 2>&1'
alias ddo='popd >/dev/null 2>&1'
alias ddl='dirs |tr " " "\n"'
alias dm=docker-machine
alias dus='du -ms .??* * 2>/dev/null|sort -n'

alias fd='find . -type d -name '
function fd0 () { find . -type d -name "$@" -print0; }
alias ff='find . -type f -name '
function ff0 () { find . -type f -name "$@" -print0; }

alias gl='git log --oneline '
alias g=git
alias gg=git-all.rb
alias ga=git-all.rb
alias gaa=gitall.sh
alias ge='grep "Exception: "'
alias gb='gaa b |egrep "^\/|^\*"'

alias h=helm

#alias i='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'

alias k=kubectl
alias kd='kubectl get all --all-namespaces'

alias ll='ls -l'
alias lt='ls -lrt'

alias m=mvn

alias n=npm

alias p=prisma
alias pg='pgrep -lf '
alias pk='pkill -f '
alias pw='pstree -w|less'
pww () { while true; do clear; date; pstree -w -p $1; sleep 5; done; }

function rot () { awk -F\| '{for(i=1;i<=NF;i++){print i" - "$i}; print "-------------" }' | egrep -v '^[0-9]+ [-][ ]+$'; }
alias rr='bundle exec rails'

alias ssr='ssh-keygen -R'
# alias ssp='ssh pna -t sudo su - user2'
alias st=stree

alias t='less -i'
alias tf=terraform
function title () { echo -ne "\033];${1}\007"; }
function ts () { date '+%Y-%m-%d-%H%M%S'; }

function utc () { TZ=UTC date '+%Y-%m-%d-%H%M%S'; }

alias v=vagrant
alias vd='vagrant destroy'
alias vh='vagrant halt'
alias vs='vagrant ssh'
vss () { vagrant ssh -c 'sudo -i'; }
alias vu='vagrant up'

alias xe='xargs egrep '
alias xe0='xargs -0 egrep '

alias y=yarn
```