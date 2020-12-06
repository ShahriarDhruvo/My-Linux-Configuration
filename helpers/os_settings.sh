# # Enable AUR
# step_message "enabling AUR"
# sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# # Change Power Settings
# while true; do
#     info_message "
#     1.Increase Blank Screen idle-time to 10 minutes
#     2.Change power button action to 'suspend'
#     3.Turn off Automatic Suspend"
# 	conf_message "change above power settings" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "applying these power management settings"
#             gsettings set org.gnome.desktop.session idle-delay 600
#             gsettings set org.gnome.settings-daemon.plugins.power power-button-action suspend
# 			gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # GRUB settings
# while true; do
# 	conf_message "change grub default timeout to 3s" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "updating grub timeout"
# 			sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub
# 			sudo update-grub
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done


# Enable AUR
step_message "enabling AUR"
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Change Power Settings
info_message "
1.Increase Blank Screen idle-time to 10 minutes
2.Change power button action to 'suspend'
3.Turn off Automatic Suspend"
conf_message "change above power settings" 

commands='
step_message "applying these power management settings" &&
gsettings set org.gnome.desktop.session idle-delay 600 &&
gsettings set org.gnome.settings-daemon.plugins.power power-button-action suspend &&
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"'

Yn_wait $commands

# GRUB settings
conf_message "change grub default timeout to 3s"

commands="
step_message 'updating grub timeout' &&
sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub &&
sudo update-grub"

Yn_wait $commands
