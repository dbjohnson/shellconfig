#!/bin/bash

dir=$PWD
cd ~/
ln -s $dir/dotfiles/.* .
ln -s $dir/dotfiles/ipython_config .ipython/profile_default/
ln -s $dir/dotfiles/matplotlibrc .matplotlib/

