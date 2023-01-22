#!/bin/bash

dir=$PWD
cd ~/

for f in "$dir/dotfiles/".[a-z]*
do
    ln -s -f "$f" .
done

mkdir -p ~/.ipython/profile_default
mkdir -p ~/.matplotlib
ln -s -f "$dir/dotfiles/ipython_config.py" .ipython/profile_default/
ln -s -f "$dir/dotfiles/matplotlibrc" .matplotlib/

