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

#Enable AUR 
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

while true; do
	conf_message "update default timeout and define custom keyboard shortcut" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "updating default timeout to 30 minutes"
			sudo echo "Defaults passwd_timeout=30" >> /etc/sudoers

			message "defining custom keyboard shortcut"
			python custom_keyboard_shortcut.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T'
			python custom_keyboard_shortcut.py 'open File manager' 'nautilus' '<Super>E'
			python custom_keyboard_shortcut.py 'open Sublime-text' 'subl' '<Control><Alt>S'
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
	conf_message "install & configure the necessary tools" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "installing necessary tools"
			#yay -S intellij #This seems to be depricated
			yay -S base-devel zsh vim tlp neofetch google-chrome brave vlc code qbittorrent xdman handbrake sublime-text gimp libreoffice-still mlocate timeshift
	       	
	       	message "installing pip and some of it's tool"
	       	yay -S python-pip
	       	pip install virtualenv django

	       	message "configuring the tools"
	       	shopt -s expand_aliases
			alias ll="ls -la"

			#For laptop
			sudo tlp start
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
			rsync -aP config-files/sublime-text-3/ ~/.config
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
	conf_message "Change default shell and set custom configuration for it" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "configuring zsh"
			# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
			sed -i 's/^[^#]*exec/#&/' install.sh
			sudo sh install.sh
			rm -rf install.sh
			git clone https://github.com/zsh-users/zsh-autosuggestions
			mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
			
			message "copying zshrc"
			sudo rm -rf ~/.zshrc
			rsync -aP config-files/.zshrc ~/

			message "changing default shell to zsh"
			chsh -s /bin/zsh
			sudo chsh -s /bin/zsh
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

sudo updatedb

message "Everything executed without any error :)"