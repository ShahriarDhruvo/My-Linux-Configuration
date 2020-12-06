# Git configuration
# while true; do
# 	conf_message "set up global email and username for github"
#     warning_message "(Edit the 'personal_Info.json' to change your email and username for github by default it is set up as NULL)"
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			git config --global user.email $(jq '.git_email' config/personal_Info.json)
#             git config --global user.name $(jq '.git_username' config/personal_Info.json)

# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Set custom keybindings
# while true; do
#     info_message "
#     1.gnome-terminal: ctrl + alt + T
#     2.nautilus (File manager): super (windows key) + E
#     3.subl (sublime-text): ctrl + alt + S"
# 	conf_message "add above custom keyboard shortcuts" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "defining custom keyboard shortcut"
# 			python helpers/add_keybindings.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T'
# 			python helpers/add_keybindings.py 'open File manager' 'nautilus' '<Super>E'
# 			python helpers/add_keybindings.py 'open Sublime-text' 'subl' '<Control><Alt>S'
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Git configuration
conf_message "set up global email and username for github"
warning_message "(Edit the 'personal_Info.json' to change your email and username for github by default it is set up as NULL)"

commands="
git config --global user.email $(jq '.git_email' config/personal_Info.json) &&
git config --global user.name $(jq '.git_username' config/personal_Info.json)"

Yn_wait $commands

# Set custom keybindings
info_message "
1.gnome-terminal: ctrl + alt + T
2.nautilus (File manager): super (windows key) + E
3.subl (sublime-text): ctrl + alt + S"
conf_message "add above custom keyboard shortcuts"

commands="
step_message 'defining custom keyboard shortcut' &&
python helpers/add_keybindings.py 'open Terminal' 'gnome-terminal' '<Control><Alt>T' &&
python helpers/add_keybindings.py 'open File manager' 'nautilus' '<Super>E' &&
python helpers/add_keybindings.py 'open Sublime-text' 'subl' '<Control><Alt>S'"

Yn_wait $commands
