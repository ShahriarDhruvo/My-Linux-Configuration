#!/bin/sh

echo "UPGRADING THE SYSTEM...."
sudo pacman -Syyu
sudo pacman -S yay

echo "INSTALLING NECESSARY TOOLS...."
yay -S zsh tlp neofetch google-chrome brave vlc intellij code qbittorrent xdman handbrake fish sublime-text gimp libreoffice-still mlocate timeshift

echo "CONFIGURING THE TOOLS...."
alias ll="ls -la"
sudo tlp start

echo "CONFIGURING SUBLIME-TEXT...."
if [ ! -d ~/Documents/my_code ]; then
	mkdir ~/Documents/my_code
fi
if [ ! -f ~/Documents/my_code/input.txt ]; then
	touch ~/Documents/my_code/input.txt
fi
if [ ! -f ~/Documents/my_code/output.txt ]; then
	touch ~/Documents/my_code/output.txt
fi
if [ ! -x "$(command -v svn)" ]; then
  sudo pacman -S subversion
fi
if [ -d ~/.config/sublime-text-3 ]; then
	rm -rf ~/.config/sublime-text-3/
fi
cp config-files/sublime-text-3/ ~/.config

echo "CONFIGURING ZSH...."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"		
git clone https://github.com/zsh-users/zsh-autosuggestions
mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -rf ~/.zshrc
cp config-files/.zshrc ~/

echo "INSTALLING & CONFIGURING VIRTUALIZATION...."
yay -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

echo "CONFIGURING THEMES...."
cp config-files/Themes_and_Icons ~/
