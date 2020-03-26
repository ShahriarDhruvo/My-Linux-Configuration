#!/bin/sh

message()
{
	echo
	echo "(@sed) $1...." | tr a-z A-Z
	echo
}

message "updating default timeout to 30 minutes"
sudo echo "Defaults passwd_timeout=30" >> /etc/sudoers

message "upgrading the system"
sudo pacman -Syyu
sudo pacman -S yay

message "installing necessary tools"
yay -S zsh tlp neofetch google-chrome brave vlc intellij code qbittorrent xdman handbrake fish sublime-text gimp libreoffice-still mlocate timeshift

message "configuring the tools"
alias ll="ls -la"
sudo tlp start

message "configuring sublime-text"
mkdir ~/Documents/my_code
touch ~/Documents/my_code/input.txt
touch ~/Documents/my_code/output.txt
if [ -d ~/.config/sublime-text-3 ]; then
	rm -rf ~/.config/sublime-text-3/
	message "sublime-text's existing config deleted"
fi
message "copying new config files"
cp -r config-files/sublime-text-3/ ~/.config

message "installing & configuring virtualization"
yay -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

message "copying themes"
cp -r config-files/Themes_and_Icons ~/

message "changing default shell to zsh"
chsh -s /bin/zsh
sudo chsh -s /bin/zsh

message "configuring zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"		
git clone https://github.com/zsh-users/zsh-autosuggestions
mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -rf ~/.zshrc
cp config-files/.zshrc ~/
message "Everything executed without any error"