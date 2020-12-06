# Theming gnome-terminal
# while true; do
# 	conf_message "change theme for gnome-terminal (Select ONE-DARK)" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			bash -c "$(wget -qO- https://git.io/vQgMr)"
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Updating database
# step_message "updating database"
# sudo updatedb


# Theming gnome-terminal
conf_message "change theme for gnome-terminal (Select ONE-DARK)" 

commands='bash -c "$(wget -qO- https://git.io/vQgMr)"'

Yn_wait $commands

# Updating database
step_message "updating database"
sudo updatedb
