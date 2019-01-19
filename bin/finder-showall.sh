#!/bin/sh

case "$1" in
    on|true|1 )
        defaults write com.apple.finder AppleShowAllFiles TRUE
        killall Finder
        ;;
    off|false|0 )
        defaults write com.apple.finder AppleShowAllFiles FALSE
        killall Finder
        ;;
esac
