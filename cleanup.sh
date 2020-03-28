#!/bin/sh

message()
{
	echo
	echo "(@sed) $1...." | tr a-z A-Z
	echo
}

conf_message()
{
	echo
	printf "(@SED) Do you wish to $1? (Y/n)"
}

message "
1. first run this File
2. then reboot
3. after that run: sh myScript.sh"

message "this cleanup script is specifically made for manjaro gnome minimalistic edition"

while true; do
	conf_message "continue" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			# Cleanup orphan packages
			yay -Rcns $(yay -Qtdq)
			yay -Rcns manjaro-hello cheese
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done