# Configuaring Sublime-text
while true; do
    conf_message "configure sublime-text"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
            echo
            echo -e ${COMMAND}"Running Commands: \"$*\""${NC}
            echo
            
            # Commands
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

            # Command status check
            if [ $? -eq 0 ]; then
                echo
                echo -e ${SUCCESS}"Successfully done...."${NC}
                echo
            else
                echo
                echo -e ${ERROR}"There is an error running the command[s]...."${NC}
                echo
            fi

            break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done
