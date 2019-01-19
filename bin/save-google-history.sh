#!/bin/bash

DIR_START=$(pwd -P)
cd ~/Library/Application\ Support/Google/Chrome/
cd "$HOME/Library/Application Support/Google/Chrome//Profile 3/"

OUT="$DIR_START/$(date '+%Y-%m-%d-%H%M%S-chrome-history.csv')"

sqlite3 History <<EOF
.headers on
.mode csv
.output $OUT
SELECT last_visit_time, url FROM urls ORDER BY last_visit_time DESC;
EOF

