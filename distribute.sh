#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/dotfiles"
find . -type f -print0 | while IFS= read -r -d '' f; do
	f="${f#./}"
	dest="$HOME/$f"
	# make directories as needed
	mkdir -p "$(dirname "$dest")"
	ln -sfn "$PWD/$f" "$dest"
	ls -l "$dest"
done
