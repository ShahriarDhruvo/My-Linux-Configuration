#!/bin/sh

# Settings
COLUMNS=$(tput cols)

# Colors
NC='\033[0m' # No Color
INFO='\033[1;35m' # PURPLE
STEP='\033[1;36m' # CYAN
WARNING='\033[0;33m' # YELLOW

warning_message()
{
    echo
    echo -e ${WARNING}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((11+$COLUMNS)/2)) "WARNING !!!"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^^}...."
    echo -e ${NC}
    echo
}

step_message()
{
    echo
    echo -e ${STEP}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^}...."
    echo -e ${NC}
    echo
}

info_message()
{
    echo
    echo -e ${INFO}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^}"
    echo -e ${NC}
    echo
}

conf_message()
{
    echo
	printf "(@SED) Do you want to $1? (Y/n)"
}

proceed_next()
{
    echo
	printf "(@SED) Do you want to proceed to the next step? (Y/n)"

    while true; do 
        read -p "" yn

        case $yn in
            [Yy]*|"" )
                clear
                break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y/y or N/n as yes or no.";;
        esac
    done
}

warning_message "before running this script first goto the 'config/personal_Info.json' file, put all of your config data and then run this. By default all of these data's are set to NULL. So if you continue without changing it, it may not configure the settings correctly"

proceed_next

info_message "
Author's information:
Shahriar Elahi Dhruvo
Student at Shahjalal University of Science & Technology (2017-2022)

How to configure it: (If for some reason you don't like mine)
1.You can edit the config/extra_software_list.txt to add/remove softwares/tools of your choice
2.Replace the sublime-text-3.zip with yours
3.Replace the .zshrc with yours
4.To add/remove extra gnome extensions edit the config/extra_gnome-extensions_list.txt
5.To add/remove extra aliases edit the config/custom_aliases.txt
6.And feel free to change any commands of this script as you like

This script is all about what will I do/change if I want to use manjaro linux as my primary Operating System
It is recommended to check this script's code before you run it. And of course I am not responsible for any of your damage"

proceed_next

# Enable AUR
step_message "enabling AUR"
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Change Power Settings
while true; do
    info_message "
    1.Increase Blank Screen idle-time to 10 minutes
    2.Change power button action to 'suspend'
    3.Turn off Automatic Suspend"
	conf_message "change above power settings" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "applying these power management settings"
            gsettings set org.gnome.desktop.session idle-delay 600
            gsettings set org.gnome.settings-daemon.plugins.power power-button-action suspend
			gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# GRUB settings
while true; do
	conf_message "change grub default timeout to 3s" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "updating grub timeout"
			sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub
			sudo update-grub
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Set custom keybindings
while true; do
    info_message "
    1.gnome-terminal: ctrl + alt + T
    2.nautilus (File manager): super (windows key) + E
    3.subl (sublime-text): ctrl + alt + S"
	conf_message "add above custom keyboard shortcuts" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "defining custom keyboard shortcut"
			python helpers/add_keybindings.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T'
			python helpers/add_keybindings.py 'open File manager' 'nautilus' '<Super>E'
			python helpers/add_keybindings.py 'open Sublime-text' 'subl' '<Control><Alt>S'
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Update the system & install necessary tools
while true; do
	conf_message "update the system & install necessary tools" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "upgrading the system & install necessary tools"
			sudo pacman -Syyu
			sudo pacman -S yay
            yay -S base-devel jq
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Update NVIDIA Gpu driver
while true; do
	conf_message "update NVIDIA Gpu driver (Select it only if you have NVIDIA GPU)" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "upgrading the NVIDIA Gpu driver"
			sudo mhwd -a pci nonfree 0300
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Enable TLP (only for laptops)
while true; do
	conf_message "add laptop configuration" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			yay -S tlp
			sudo tlp start
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Git configuration
while true; do
	conf_message "set up global email and username for github"
    warning_message "(Edit the 'personal_Info.json' to change your email and username for github by default it is set up as NULL)"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			git config --global user.email $(jq '.git_email' config/personal_Info.json)
            git config --global user.name $(jq '.git_username' config/personal_Info.json)

	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Install extra softwares
while true; do
    clear
    cat config/extra_softwares_list.txt
    echo
	conf_message "install these softwares above"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "running update again for safety measures :)"
			yay -Syyu

			step_message "installing necessary tools"
	       	yay -S - < config/extra_softwares_list.txt
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Install extra gnome-extensions
while true; do
    clear
    cat config/extra_gnome-extensions_list.txt
    echo
	conf_message "install these gnome extensions above"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "installing extra gnome extensions"
	       	yay -S - < config/extra_gnome-extensions_list.txt

            # Installing NVIDIA GPU Stats Tool
            git clone https://github.com/ethanwharris/gnome-nvidia-extension.git
            cd gnome-nvidia-extension
            make
            make install
            cd ..
            rm -rf gnome-nvidia-extension
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Configuaring Sublime-text
while true; do
	conf_message "configure sublime-text" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "configuring sublime-text"
			mkdir ~/Documents/my_code
			touch ~/Documents/my_code/input.txt
			touch ~/Documents/my_code/output.txt

			if [ -d ~/.config/sublime-text-3 ]; then
				rm -rf ~/.config/sublime-text-3/
				step_message "sublime-text's existing config deleted"
			fi

			step_message "copying new sublime-config files"
            unzip config/sublime-text-3.zip
			mv sublime-text-3 ~/.config
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Installing & Configuaring virt-manager (virtualization softwares)
while true; do
	conf_message "install & configure virtualization" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "installing & configuring virtualization"
			yay -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat

			sudo systemctl enable libvirtd.service
			sudo systemctl start libvirtd.service

            # Enable this if virt-manager says your default is not active
            # sudo virsh net-autostart --network default
            # sudo virsh net-start default
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Configuaring & Installing additional themes and fonts
while true; do
	conf_message "configure themes and fonts" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
            # Date-time configuration
			step_message "changing default date-time behaviour"
            timedatectl set-ntp 1 # Automatic update date-time
            gsettings set org.gnome.desktop.interface clock-format 12h
            gsettings set org.gnome.desktop.interface clock-show-date true
            gsettings set org.gnome.desktop.interface clock-show-seconds true

            # Fonts
			step_message "copying fonts"
            unzip config/fonts.zip
			sudo mv fonts/* /usr/share/fonts/TTF/
            rm -r fonts

            # Configuaring & Installing necessary tools
            mkdir ~/.themes ~/.icons
            # yay -S mojave-gtk-theme canta-icon-theme-git
            yay -S canta-icon-theme-git

            # Theme -> Applications: Ant-Dracula 
            git clone -b alt-style --single-branch https://github.com/dracula/gtk.git
            mv gtk ~/.themes/
            gsettings set org.gnome.desktop.interface gtk-theme "gtk"
            gsettings set org.gnome.desktop.wm.preferences theme "gtk"

            # Theme -> Shell: Mojave-dark
            # gsettings set org.gnome.shell.extensions.user-theme name "Mojave-dark"
            # Theme -> Shell: Matcha-dark-azul
            gsettings set org.gnome.shell.extensions.user-theme name "Matcha-dark-azul"

            # Theme -> Cursor: PearDark
            unzip config/PearDarkCursors.zip -d ~/.icons
            gsettings set org.gnome.desktop.interface cursor-theme 'PearDarkCursors'

            # Background -> Image: 1.jpg
            wallpaper_path=$(pwd)"/config/wallpapers/W1.jpg"
            gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"

            #Theme -> Icons: Canta
            gsettings set org.gnome.desktop.interface icon-theme 'Canta'

            #Theme -> Icons: numix-circle + canta
            # yay -S numix-circle-icon-theme-git canta-icon-theme-git
            # gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle-Light'
            # gsettings set org.gnome.desktop.interface icon-theme 'Canta'

            # Theme -> Cursor: Mcmojave-cursors
            # yay -S mcmojave-cursors
            # gsettings set org.gnome.desktop.interface cursor-theme 'mcmojave-cursors'
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Theming gnome-terminal
while true; do
	conf_message "change theme for gnome-terminal (Select ONE-DARK)" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			bash -c "$(wget -qO- https://git.io/vQgMr)"
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# # Using Manjaro's default zsh configurations

# # Installing oh-my-zsh
# while true; do
# 	conf_message "intall oh-my-zsh" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "installing oh-my-zsh"
# 			# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#           yay -S oh-my-zsh-git
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # Configuaring ZSH
# while true; do
# 	conf_message "set custom configuration for zsh" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "configuring zsh"
#           git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
			
# 			step_message "replacing .zshrc"
# 			sudo rm -rf ~/.zshrc
# 			cp config/.zshrc ~/

# 			# step_message "changing default shell to zsh"
# 			# chsh -s /bin/zsh
# 			# sudo chsh -s /bin/zsh
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Updating database
step_message "updating database"
sudo updatedb

# This will add "most" package functionality for manuals
while true; do
	conf_message "add 'most' package functionality for manuals" 
    read -p "" yn
    
    case $yn in
        [Yy]*|"" )
			yay -S most
			echo "export PAGER=most" >> ~/.profile
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Adding custom aliases
while true; do
	clear
    cat config/custom_aliases.txt
    echo
	conf_message "add these custom aliases above"
    read -p "" yn
    
    case $yn in
        [Yy]*|"" )
			cat config/custom_aliases.txt >> ~/.zshrc
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

# Cleanup orphan packages
while true; do
	conf_message "remove unneeded packages" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			yay -Rns manjaro-hello
			yay -Rns $(yay -Qtdq)
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

info_message "
Success....................................
Everything executed without any error :)..."

proceed_next

# Change the Password
while true; do
    warning_message "It is recommended to change your current user password with a strong one"
	conf_message "change your current password" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			passwd
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done

warning_message "You need to restart your system next. After restart check out the 'post_config/post_configuration.txt' for furthur customizations"

# Reboot the system
while true; do
	conf_message "restart the system now"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			sudo reboot
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done
