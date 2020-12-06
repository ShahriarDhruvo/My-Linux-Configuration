# # Update the system & install necessary tools
# while true; do
# 	conf_message "update the system & install necessary tools" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "upgrading the system & install necessary tools"
# 			sudo pacman -Syyu
# 			sudo pacman -S yay
#             yay -S base-devel jq
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # Update NVIDIA Gpu driver
# while true; do
# 	conf_message "update NVIDIA Gpu driver (Select it only if you have NVIDIA GPU)" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "upgrading the NVIDIA Gpu driver"
# 			sudo mhwd -a pci nonfree 0300
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # Enable TLP (only for laptops)
# while true; do
# 	conf_message "add laptop configuration" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			yay -S tlp
# 			sudo tlp start
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done


# Update the system & install necessary tools
conf_message "update the system & install necessary tools"

commands='
step_message "upgrading the system & install necessary tools" &&
sudo pacman -Syyu &&
sudo pacman -S yay &&
yay -S base-devel jq'

Yn_wait $commands

# Update NVIDIA Gpu driver
conf_message "update NVIDIA Gpu driver (Select it only if you have NVIDIA GPU)"

commands='
step_message "upgrading the NVIDIA Gpu driver" &&
sudo mhwd -a pci nonfree 0300'

Yn_wait $commands

# Enable TLP (only for laptops)
conf_message "add laptop configuration" 

commands='
step_message "enabling TLP" &&
yay -S tlp &&
sudo tlp start'

Yn_wait $commands
