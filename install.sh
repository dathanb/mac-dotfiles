#!/bin/bash

# copy everything except the .git folder to the home directory
for f in `ls -a | grep -v '^\.$' | grep -v '^\.\.$' | grep -v '^.git$' | grep -v '^zsh$' | grep -v '^install.sh$'`; do
    cp -r $f ~/
done
