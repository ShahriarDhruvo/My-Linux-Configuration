# Cleanup orphan packages
# while true; do
# 	conf_message "remove unneeded packages" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			yay -Rns manjaro-hello
# 			yay -Rns $(yay -Qtdq)
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

conf_message "remove unneeded packages" 

commands='
yay -Rns manjaro-hello &&
yay -Rns $(yay -Qtdq)'

Yn_wait $commands
