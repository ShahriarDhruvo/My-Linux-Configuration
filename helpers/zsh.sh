# # Installing oh-my-zsh
# while true; do
# 	conf_message "intall oh-my-zsh" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "installing oh-my-zsh"
# 			# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#             yay -S oh-my-zsh-git
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# # Configuaring ZSH
# while true; do
# 	conf_message "set custom configuration for zsh" 
#     read -p "" yn

#     case $yn in
#         [Yy]*|"" )
# 			step_message "configuring zsh"
#             git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
			
# 			step_message "replacing .zshrc"
# 			sudo rm -rf ~/.zshrc
# 			cp config/.zshrc ~/

# 			# step_message "changing default shell to zsh"
# 			# chsh -s /bin/zsh
# 			# sudo chsh -s /bin/zsh
# 	       	break;;
#         [Nn]* ) break;;
#         * ) echo "Please answer Y/y or N/n as yes or no.";;
#     esac
# done

# Installing oh-my-zsh
conf_message "intall oh-my-zsh"

commands='
step_message "installing oh-my-zsh" &&
yay -S oh-my-zsh-git'

# commands='
# step_message "installing oh-my-zsh" &&
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

Yn_wait $commands

# Configuaring ZSH
conf_message "set custom configuration for zsh"

commands='
step_message "configuring zsh" &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
step_message "replacing .zshrc" &&
sudo rm -rf ~/.zshrc &&
cp config/.zshrc ~/'

Yn_wait $commands
