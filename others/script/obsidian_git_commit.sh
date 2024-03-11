#!/bin/bash

# cd
cd /mnt/d/obsidian/diary/

# add 
git add .

# commit
date +%Y%m%d | awk "git commit -m "'"$0"'" "

awk -v 

