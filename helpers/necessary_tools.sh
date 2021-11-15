# # Update the system & install necessary tools
# while true; do
# 	conf_message "update the system & install necessary tools" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "upgrading the system & install necessary tools"
# 			sudo pacman -Syyuu
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
yay -S base-devel'

Yn_wait $commands

# Update NVIDIA Gpu driver
conf_message "update NVIDIA Gpu driver (Select it only if you have NVIDIA GPU)"

commands='
step_message "upgrading the NVIDIA Gpu driver" &&
sudo mhwd -a pci nonfree 0300'

Yn_wait $commands

## Enable TLP (only for laptops)
# conf_message "add laptop TLP(Better battery management) configuration" 

# step_message "enabling TLP" &&
# yay -S tlp &&
# sudo tlp start

# Enable Auto-cpufreq (only for laptops)
conf_message "add laptop Auto-cpufreq(power management tool) configuration" 

# For ubuntu & debian
# commands='
# step_message "enabling Auto-cpufreq" &&
# git clone https://github.com/AdnanHodzic/auto-cpufreq.git &&
# cd auto-cpufreq && sudo ./auto-cpufreq-installer &&
# cd .. && sudo rm -rf auto-cpufreq'

commands='
step_message "enabling Auto-cpufreq" &&
yay -S auto-cpufreq'

Yn_wait $commands
