---
layout: default
---
- [home](/index.md)
- [alias](/shell-bash-alias.md)
- [bashrc](/shell-bash-bashrc.md)

---
# BASH Notes

## Shared setup

```
# sample shared .bashrc and aliases
[ -e ~/.bash/bashrc ] && . ~/.bash/bashrc
[ -e ~/.bash/aliases.sh ] && . ~/.bash/aliases.sh
```

## Source and Export Variables
```
set -a; source .env; set +a
```

## Exit on Error
```
#! /bin/bash -eu
set -o pipefail
```

## Local Variables
```
func() {
  local arg1="${1}"
  local x="${2%/}"
```

## Run command as user that does not have a shell
```
su - -s /bin/bash tomcat8
```

## Lots of shell trickery

- <https://github.com/nginxinc/docker-nginx/blob/master/generate-stackbrew-library.sh>


## Array examples
```
declare -A aliases
aliases=(
	[mainline]='1 1.13 latest'
	[stable]='1.12'
)
versions=( */ )
versions=( "${versions[@]%/}" ) # add to existing
```

## Resolve path to script
```
# Need to play with this
self="$(basename "$BASH_SOURCE")"
cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
```

## check remote shell vars
```
echo env |ssh -T mdc |grep TARG
```

## Test Arg processing
### file mro.2
```
#!/bin/sh
echo -------------
for f in "$@"; do
    echo \"$f\"
done
```

### file mro.1
```
#!/bin/sh

function command () {
    echo
    echo "command line: $@"
    echo "command output:"
    echo "-------------------------------"
    "$@"
    code=$?
    echo "-------------------------------"
    return $code
}
```

### Tests
```
./mro.2 a b c
./mro.2 "a b" c
./mro.2 a "b c"

command ./mro.2 a b c
command ./mro.2 "a b" c
command ./mro.2 a "b c"
```

## Option processing
```
OPTIND=1
while getopts "hdp" opt; do
    case "$opt" in
        h)   usage ;;
        '?') usage ;;
        d) PROFILE=dev ;;
        p) PROFILE=prod ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.
```

## Gen random strings
```
export CHART_BUCKET=s3://example-chart-store-$(cat /dev/random | LC_ALL=C tr -dc "[:alpha:]" | tr '[:upper:]' '[:lower:]' | head -c 32)

openssl rand 16 -hex
node -e "console.log(require('crypto').randomBytes(256).toString('base64'));"
uuidgen
pwgen 50 1 -s > passphrase
# Or use KeePassX generator

ruby -rsecurerandom -e 'puts SecureRandom.hex(32)'

cat /proc/sys/kernel/random/uuid

```
- <https://www.random.org/passwords/?num=2&len=20&format=html&rnd=new>

## Sequence
```
for i in {0..9}; do echo $i; done
for i in `seq 1 5`;do x; done
```

## list completions
```
complete #list
complete -F _asdf b # assign to function
```

# load completion functions from tools like eksctl
```
. <(eksctl completion bash)
```

## Base dir
```
DIR=$(dirname $([ -L $0 ] && readlink $0 || echo $0))
DIR=$(cd $DIR>/dev/null; pwd -P)
```

## dump env and functions
`typeset`

## see definitions
`type <str>`

## Tail a file from the beginning
`tail -0F`


## Sample xargs
```
echo webserver loadbalancer database | tr ' ' '\n' \
| xargs -I % -P 3 bash -c 'ansible-playbook $1.yml' -- %
```

## remove root from list of files
- ${f##*/}
```
for f in /sys/devices/system/cpu/vulnerabilities/*; do echo "${f##*/} -" $(cat "$f"); done
```
