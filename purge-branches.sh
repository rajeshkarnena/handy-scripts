#!/bin/bash
# Purge branches of all git repos in current directory which start with given arg name
# Usage: ./purge-branches.sh <folder name prefix>

for d in ./"$1"*; do (cd "$d" && echo $d && git branch | grep -v '^*' | xargs git branch -d); done
