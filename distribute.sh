#!/bin/bash

dir=$PWD
cd ~/

for f in "$dir/dotfiles/".[a-z]*
do
    ln -s -f "$f" .
done
ln -s -f "$dir/dotfiles/ipython_config.pm" .ipython/profile_default/
ln -s -f "$dir/dotfiles/matplotlibrc" .matplotlib/

