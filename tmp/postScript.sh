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
	conf_message "set custom configuration for zsh" 
    read -p "" yn
    case $yn in
        [Yy]*|"" )
			message "configuring zsh"
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

message "
Everything executed without any error :)
It is recommended to change your password to a strong one"

while true; do
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