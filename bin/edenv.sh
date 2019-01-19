#!/bin/bash

less ~/.bashrc

CHG=false
if ! cmp ~/.bashrc ~/ws/dev-utils/myron/env/bashrc; then
	CHG=true
fi

cp ~/.bashrc ~/ws/dev-utils/myron/env/bashrc
cp ~/.ssh/config ~/ws/dev-utils/myron/env/ssh_config
cp ~/.gitconfig ~/ws/dev-utils/myron/env/gitconfig

$CHG && exec bash
