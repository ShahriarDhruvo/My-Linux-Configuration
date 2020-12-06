# Adding custom aliases
# while true; do
# 	clear
#     cat config/custom_aliases.txt
#     echo
# 	conf_message "add these custom aliases above"
#     read -p "" yn
    
#     case $yn in
#         [Yy]*|"" )
# 			cat config/custom_aliases.txt >> ~/.zshrc
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

clear
cat config/custom_aliases.txt
echo
conf_message "add these custom aliases above"

commands='cat config/custom_aliases.txt >> ~/.zshrc'

Yn_wait $commands
