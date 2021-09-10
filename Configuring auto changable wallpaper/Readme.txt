Copy the hidden .change_wallpapers.sh script in home directory and add this to the procfile:

# start my custom script for setting random background wallpapers
if [ -f "$HOME/.change_wallpapers.sh" ] ; then
    bash $HOME/.change_wallpapers.sh &
fi
