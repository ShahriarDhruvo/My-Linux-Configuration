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
