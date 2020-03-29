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
1. First run: sh startupScript.sh
2. Then reboot
3. After that run: sh mainScript.sh
4. Reboot again (Please manually do this as this one will not prompt you to do so like other scripts do in this list...)
5. And lastly run: sh postScript.sh
6. Then reboot again
And........then you are done....... :)"

# Enable AUR 
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# while true; do
# 	conf_message "update default timeout" 
#     read -p "" yn
#     case $yn in
#         [Yy]*|"" )
# 			message "updating default timeout to 30 minutes"
# 			sudo echo "Defaults passwd_timeout=30" >> /etc/sudoers
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# GRUB settings
while true; do
	conf_message "change grub default timeout to 1s" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "updating grub timeout"
			sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/g' /etc/default/grub
			sudo update-grub
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "define custom keyboard shortcut" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "defining custom keyboard shortcut"
			python add_custom_keyboard_shortcut.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T'
			python add_custom_keyboard_shortcut.py 'open File manager' 'nautilus' '<Super>E'
			python add_custom_keyboard_shortcut.py 'open Sublime-text' 'subl' '<Control><Alt>S'
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "update the system" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "upgrading the system"
			sudo pacman -Syyu
			sudo pacman -S yay
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "reboot the system now" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			sudo reboot
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done