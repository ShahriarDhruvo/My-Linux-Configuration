#!/bin/sh

$isInstalled = which fish

if $isInstalled != "/usr/bin/fish":
	yay -S fish
else:
	echo "Fish is already installed"
