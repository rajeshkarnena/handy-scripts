#!/bin/bash

# Usage: ./multiple-git.sh status
for d in ./*/ ; do (cd "$d" && echo $d && git $*); done
