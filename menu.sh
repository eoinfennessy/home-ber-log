#!/bin/bash
# Author: Eoin Fennessy

source ./utils/colours.sh

./utils/print_logo.sh
sleep 0.1

# Displays all select options in one column
COLUMNS=0
menu_options=("View All Records" "Add Record" "Search Records"
              "Remove Record(s)" "Email Householder(s)" "Exit")

while true; do
    clear
    echo -e "${COL_HEAD}            Main Menu            ${COL_OFF}"
    PS3=$"${COL_PROMPT_PS3}Please enter your choice (1-6): ${COL_OFF_PS3}"
    select option in "${menu_options[@]}"; do
        case $option in
        "View All Records")
            ./utils/display_records_table.sh < ./ber_details.csv | less
            ;;
        "Add Record")
            ./add.sh
            ;;
        "Search Records")
            ./search/search_menu.sh
            ;;
        "Remove Record(s)")
            ./remove.sh
            ;;
        "Email Householder(s)")
            ./Email.sh
            ;;
        "Exit")
            echo "Goodbye!"
            sleep 0
            exit 0
            ;;
        *) 
            echo -e "${COL_ERR}${REPLY} is not a valid option${COL_OFF}"
            sleep 1.5
            ;;
        esac
        break
    done
done
