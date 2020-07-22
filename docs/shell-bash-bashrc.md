- [home](/index.md)
- [bash](/shell-bash.md)
- [alias](/shell-bash-alias.md)
---

```
#export LC_ALL=C
export PAGER=less
export EDITOR=vi
export TZ=America/Denver

set -o emacs; set +o vi

PATH=$HOME/bin:$PATH
PATH=$PATH:/usr/local/sbin
# [ -d "$HOME/.yarn/bin" ] && PATH=$PATH:$HOME/.yarn/bin
export PATH

export CDPATH=.:~:~/ws:~/ws/code:~/ws/deployment/fab:~/ws/other

# create separate history file per tty
TTY=`tty`
if [ "x$TTY" != "x" ]; then
    TTY=`echo $TTY |sed -e 's/.*\(tty.*\)/\1/'`
    export HISTFILE=$HOME/.bash_history_$TTY
fi
export HISTFILESIZE=2000
export HISTTIMEFORMAT='%F %T - '

# Bash completions
if [ -d ~/.completion ]; then
    for f in ~/.completion/*-completion; do source $f; done
fi

source ~/.git-prompt.sh

if [ `hostname` = 'somename.local' ]; then
  export PS1='\[\033[34m\]\h\[\033[m\] \t $(__git_ps1 "(%s) ")\w\$ '
else
  export PS1='\[\033[33m\]\h\[\033[m\] \t $(__git_ps1 "(%s) ")\w\$ '
fi


```