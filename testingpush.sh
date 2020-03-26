some_func()
{
	while true; do
		read -p "Do you wish to install this program? (Y/n)" yn
		case $yn in
		    [Yy]*|"" )
		    	$1 $2 $3 $4
			   	break;;
		    [Nn]* ) exit;;
		    * ) echo "Please answer Y/y or N/n.";;
		esac
	done
}

some_func "yay -Syyu"
