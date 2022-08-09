#!/bin/bash

# Simple bash script to look for thesaurus entries online.
# Only two dependencies are needed: dmenu (alternatively, you can use fzf) and xsel (to manage your clipboard).
# Note: this is a thesaurus, so antonyms are also included.

# Input word on dmenu. Remove the font (-fn) flag if not desired.
word=$(dmenu -c -fn "Fira Code Nerd Font" -p "Thesaurus")

# have curl pull entries from Merriam Webster
# grep command to trim HTML
# cut command isolates the available entries for easy selection
# select desired word using dmenu

selection=$(curl https://www.merriam-webster.com/thesaurus/$word | \
	grep -Eo '<a href="/thesaurus/[a-z]\w*' | \
	cut -d\/ -f3 | \
	dmenu -c -i -fn "Fira Code Nerd Font" -l 20)

# automatically send selected word to clipboard
# trim command is used to ensure that there is no trailing new space

echo $selection | tr -d "\n" | xsel -b
