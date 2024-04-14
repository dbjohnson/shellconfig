# /bin/bash

cd dotfiles
for f in $(find . -type f)
do
	# make directories as needed
	if [ "$(dirname "$f")" != "." ]; then
		mkdir -p "~/$(dirname "$f")"
	fi
	ln -s -f "$(realpath $f)" "$(realpath ~)/$f"
	echo $f
	echo $(ls -l "$(realpath ~)/$f")
done
