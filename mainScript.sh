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

while true; do
	conf_message "install necessary tools" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "running update again for safety measures :)"
			yay -Syyu

			message "installing necessary tools"
			# yay -S intellij #This seems to be depricated
			# yay -S base-devel zsh vim neofetch google-chrome brave vlc code qbittorrent xdman handbrake sublime-text gimp libreoffice-still mlocate timeshift
	       	yay -S - < softwares_and_tools.txt

	       	message "installing pip and some of it's tool"
	       	pip install virtualenv django

	  		# message "configuring the tools"
	  		# shopt -s expand_aliases
			# alias ll="ls -la"
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "configure sublime-text" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "configuring sublime-text"
			mkdir ~/Documents/my_code
			touch ~/Documents/my_code/input.txt
			touch ~/Documents/my_code/output.txt
			if [ -d ~/.config/sublime-text-3 ]; then
				rm -rf ~/.config/sublime-text-3/
				message "sublime-text's existing config deleted"
			fi
			message "copying new config files"
			rsync -aP config-files/sublime-text-3 ~/.config
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "install & configure virtualization" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "installing & configuring virtualization"
			yay -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
			sudo systemctl enable libvirtd.service
			sudo systemctl start libvirtd.service
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "configure themes and fonts" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "copying themes & icons files"
			rsync -aP config-files/Themes_and_Icons/ ~/
			message "copying fonts"
			sudo rsync -aP config-files/fonts/ /usr/share/fonts/TTF/
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "change theme for gnome-terminal (ONE-DARK: 122)" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			bash -c "$(wget -qO- https://git.io/vQgMr)"
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

while true; do
	conf_message "intall oh-my-zsh" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "installing oh-my-zsh"
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			# curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
			# sed -i 's/^[^#]*exec/#&/' install.sh
			# sudo sh install.sh
			# rm -rf install.sh
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# This section will not run as the shell has been changed by previous commands!
# while true; do
# 	conf_message "reboot the system now" 
#     read -p "" yn
#     case $yn in
#         [Yy]*|"" )
# 			sudo reboot
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done
