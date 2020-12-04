# Installing & Configuaring virt-manager (virtualization softwares)
while true; do
	conf_message "install & configure virtualization" 
    read -p "" yn

    case $yn in
        [Yy]*|"" )
			step_message "installing & configuring virtualization"
			yay -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat

			sudo systemctl enable libvirtd.service
			sudo systemctl start libvirtd.service

            # Enable this if virt-manager says your default is not active
            # sudo virsh net-autostart --network default
            # sudo virsh net-start default
	       	break;;
        [Nn]* ) break;;
        * ) echo "Please answer Y/y or N/n as yes or no.";;
    esac
done
