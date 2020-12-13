#!/bin/sh

# Settings
COLUMNS=$(tput cols)

# Colors
NC='\033[0m' # No Color
INFO='\033[1;35m' # Light PURPLE
STEP='\033[1;36m' # Light CYAN
ERROR='\033[1;31m' # Light RED
SUCCESS='\033[1;32m' # Light GREEN
WARNING='\033[0;33m' # YELLOW
COMMAND='\033[1;34m' # Light BLUE

clear

warning_message()
{
    echo
    echo -e ${WARNING}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((11+$COLUMNS)/2)) "WARNING!!!"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^^}...."
    echo -e ${NC}
    echo
}

step_message()
{
    echo
    echo -e ${STEP}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^}...."
    echo -e ${NC}
    echo
}

info_message()
{
    echo
    echo -e ${INFO}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^}"
    echo -e ${NC}
    echo
}

success_message()
{
    echo
    echo -e ${SUCCESS}
	printf "%*s\n" $(((6+$COLUMNS)/2)) "(@SED)"
    echo
	printf "%*s\n" $(((${#1}+$COLUMNS)/2)) "${1^}"
    echo -e ${NC}
    echo
}

conf_message()
{
    echo
	printf "${STEP}(@SED) Do you want to $1? (Y/n)${NC}"
}

proceed_next()
{
    echo
	printf "${STEP}(@SED) Do you want to proceed to the next step? (Y/n)${NC}"

    while true; do 
        read -p "" yn

        case $yn in
            [Yy]*|"" )
                clear
                break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y/y or N/n as yes or no.";;
        esac
    done
}

Yn_wait()
{
    while true; do
        read -p "" yn

        case $yn in
            [Yy]*|"" )
                echo
                echo -e ${COMMAND}"Running Commands: \"$*\""${NC}
                echo
                eval $*

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
}

info_message "welcome, maximize your terminal window and focus on what does it do :)"
