# Configuaring & Installing additional themes and fonts
while true; do
    conf_message "configure themes and fonts" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
            echo
            echo -e ${COMMAND}"Running Commands: \"$*\""${NC}
            echo
            
            # Commands
            # Date-time configuration
			step_message "changing default date-time behaviour"
            timedatectl set-ntp 1 # Automatic update date-time
            gsettings set org.gnome.desktop.interface clock-format 12h
            gsettings set org.gnome.desktop.interface clock-show-date true
            gsettings set org.gnome.desktop.interface clock-show-seconds true

            # Fonts
			step_message "copying fonts"
            unzip config/fonts.zip
			sudo mv fonts/* /usr/share/fonts/TTF/
            rm -r fonts

            # Configuaring & Installing necessary tools
            mkdir ~/.themes ~/.icons
            # yay -S mojave-gtk-theme canta-icon-theme-git
            yay -S canta-icon-theme-git

            # Theme -> Applications: Ant-Dracula 
            git clone -b alt-style --single-branch https://github.com/dracula/gtk.git
            mv gtk ~/.themes/
            gsettings set org.gnome.desktop.interface gtk-theme "gtk"
            gsettings set org.gnome.desktop.wm.preferences theme "gtk"

            # Theme -> Shell: Mojave-dark
            # gsettings set org.gnome.shell.extensions.user-theme name "Mojave-dark"
            # Theme -> Shell: Matcha-dark-azul
            gsettings set org.gnome.shell.extensions.user-theme name "Matcha-dark-azul"

            # Theme -> Cursor: PearDark
            unzip config/PearDarkCursors.zip -d ~/.icons
            gsettings set org.gnome.desktop.interface cursor-theme 'PearDarkCursors'

            # Background -> Image: 1.jpg
            wallpaper_path=$(pwd)"/config/wallpapers/W1.jpg"
            gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"

            #Theme -> Icons: Canta
            gsettings set org.gnome.desktop.interface icon-theme 'Canta'

            #Theme -> Icons: numix-circle + canta
            # yay -S numix-circle-icon-theme-git canta-icon-theme-git
            # gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle-Light'
            # gsettings set org.gnome.desktop.interface icon-theme 'Canta'

            # Theme -> Cursor: Mcmojave-cursors
            # yay -S mcmojave-cursors
            # gsettings set org.gnome.desktop.interface cursor-theme 'mcmojave-cursors'

            # Command status check
            if [ $? -eq 0 ]; then
                echo
                echo -e ${SUCCESS}"Successfully done...."${NC}
                echo
            else
                echo
                echo -e ${ERROR}"There is an error running the command[s]...."${NC}
                echo
            fi

            break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done
