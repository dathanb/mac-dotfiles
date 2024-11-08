#!/bin/bash

# copy everything except the .git folder to the home directory
for f in `ls -a | grep -v "README.md" | grep -v '^\.$' | grep -v '^\.\.$' | grep -v '^.git$' | grep -v '^install.sh$'`; do
    cp -r -v $f ~/
done


RED='\033[1;31m'
BLUE='\033[1;34m'
CLEAR_COLOR='\033[0m'

printf "%sNOTE%s You may need to run %smetatron refresh%s to get the git proxy re-added to your .gitconfig file%s\n" "${RED}" "${CLEAR_COLOR}" "${BLUE}" "${CLEAR_COLOR}"