# Initialization
. ./helpers/init.sh

# Tips & Warnings
. ./helpers/tips.sh

# AUR, Power, GRUB, Keybindings
. ./helpers/os_settings.sh

# GIT, Keybindings
. ./helpers/git_keybindings.sh

# Base softwares, NVIDIA GPU Driver, TLP
. ./helpers/necessary_tools.sh

# Extra softwares, gnome-extensions
. ./helpers/softwares_extensions.sh

# Configure sublime-text
. ./helpers/sublime_text.sh

# Install & Configure virtualization
. ./helpers/virtualization.sh

# Configure themes, icons, fonts
. ./helpers/themes.sh

# Configure gnome terminal
. ./helpers/gnome_terminal.sh

# Configure ZSH
# . ./helpers/zsh.sh
# Using Manjaro's default zsh configurations

# Configure most package for manuals (Linux 'man' command)
. ./helpers/most.sh

# Configure aliases
. ./helpers/aliases.sh

# Remove unneeded packages
. ./helpers/cleanup.sh

success_message "
Success....................................
Everything executed without any error :)..."

proceed_next

# Post configuration
. ./helpers/post_config.sh
