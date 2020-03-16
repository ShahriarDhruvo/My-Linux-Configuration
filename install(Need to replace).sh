#!/bin/bash


cd ~/Documents/
if [ ! -d my_code ]; then
	mkdir my_code
fi
if [ ! -f my_code/input.txt ]; then
	touch my_code/input.txt
fi
if [ ! -f my_code/output.txt ]; then
	touch my_code/output.txt
fi

if [ ! -x "$(command -v svn)" ]; then
  sudo pacman -S subversion
fi
cd ~/.config
if [ -d sublime-text-3 ]; then
	rm -rf sublime-text-3/
fi
# svn export https://github.com/st3inum/sublime-text-3.git/trunk/sublime-text-3
svn export https://github.com/st3inum/test.git/trunk/sublime-text-3
