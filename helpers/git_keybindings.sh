# Set custom keybindings
# while true; do
#     info_message "
#     1.gnome-terminal: ctrl + alt + T
#     2.nautilus (File manager): super (windows key) + E
#     3.subl (sublime-text): ctrl + alt + S"
# 	conf_message "add above custom keyboard shortcuts" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "defining custom keyboard shortcut"
# 			python helpers/add_keybindings.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T'
# 			python helpers/add_keybindings.py 'open File manager' 'nautilus' '<Super>E'
# 			python helpers/add_keybindings.py 'open Sublime-text' 'subl' '<Control><Alt>S'
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

while true; do
    warning_message "You better pay attention for this section"
	conf_message "set up global email and username for github"
    read -p "" yn

    case $yn in
        [Yy]*|"" )
            echo
            echo -e ${COMMAND}"Running Commands: git config --global user.email email && git config --global user.name username"${NC}
            echo
            
            # Commands
            echo
            read -p "Enter your Git user email: " email

            # Email validity check
            regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"
            until [[ $email =~ $regex ]]
            do
                echo
                echo -e "${ERROR}Email address $email is invalid${NC}"
                echo
                read -p "Enter your Git user email: " email
            done
            
            echo
            echo -e "${SUCCESS}Email address $email is valid${NC}"

			git config --global user.email $email

            echo
            read -p "Enter your Git username: " username
            git config --global user.name $username

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

# Set custom keybindings
info_message "
1.gnome-terminal: ctrl + alt + T
2.nautilus (File manager): super (windows key) + E
3.subl (sublime-text): ctrl + alt + S"
conf_message "add above custom keyboard shortcuts"

commands="
step_message 'defining custom keyboard shortcut' &&
python helpers/add_keybindings.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T' &&
python helpers/add_keybindings.py 'open File manager' 'nautilus' '<Super>E' &&
python helpers/add_keybindings.py 'open Sublime-text' 'subl' '<Control><Alt>S'"

Yn_wait $commands
