#!/bin/sh

message()
{
	echo
	echo "(@sed) $1...." | tr a-z A-Z
	echo
}

m_message()
{
	echo
	echo "(@SED) $1"
	echo
}

conf_message()
{
	echo
	printf "(@SED) Do you wish to $1? (Y/n)"
}

m_message "
1. First run: sh startupPack.sh
2. Then reboot
3. After that run: sh myScript.sh
4. For some cleanup run: sh cleanup.sh"

message "this cleanup script is specifically made for manjaro gnome minimalistic edition"

while true; do
	conf_message "continue" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			# Cleanup orphan packages
			yay -Rns $(yay -Qtdq)
			yay -Rcns manjaro-hello cheese
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done