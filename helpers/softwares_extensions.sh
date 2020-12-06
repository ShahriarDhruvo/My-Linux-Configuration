# # Install extra softwares
# while true; do
#     clear
#     cat config/extra_softwares_list.txt
#     echo
# 	conf_message "install these softwares above"
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "running update again for safety measures :)"
# 			yay -Syyu

# 			step_message "installing necessary tools"
# 	       	yay -S - < config/extra_softwares_list.txt
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # Install extra gnome-extensions
# while true; do
#     clear
#     cat config/extra_gnome-extensions_list.txt
#     echo
# 	conf_message "install these gnome extensions above"
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "installing extra gnome extensions"
# 	       	yay -S - < config/extra_gnome-extensions_list.txt

#             # Installing NVIDIA GPU Stats Tool
#             git clone https://github.com/ethanwharris/gnome-nvidia-extension.git
#             cd gnome-nvidia-extension
#             make
#             make install
#             cd ..
#             rm -rf gnome-nvidia-extension
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Install extra softwares
clear
cat config/extra_softwares_list.txt
echo
conf_message "install these softwares above"

commands='
step_message "running update again for safety measures :)" &&
yay -Syyu && step_message "installing necessary tools" &&
yay -S - < config/extra_softwares_list.txt'

Yn_wait $commands

# Install extra gnome-extensions
clear
cat config/extra_gnome-extensions_list.txt
echo
conf_message "install these gnome extensions above"

commands='
step_message "installing extra gnome extensions" &&
yay -S - < config/extra_gnome-extensions_list.txt &&
git clone https://github.com/ethanwharris/gnome-nvidia-extension.git &&
cd gnome-nvidia-extension && make && make install && cd .. &&
rm -rf gnome-nvidia-extension'

Yn_wait $commands
