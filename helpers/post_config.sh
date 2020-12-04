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
