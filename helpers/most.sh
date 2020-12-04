# This will add "most" package functionality for manuals
while true; do
	conf_message "add 'most' package functionality for manuals" 
    read -p "" yn
    
    case $yn in
        [Yy]*|"" )
			yay -S most
			echo "export PAGER=most" >> ~/.profile
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done
