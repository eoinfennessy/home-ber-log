#!/bin/bash
# Author: Eoin Fennessy
# Main menu loop for "Home BER Log", a CLI app for viewing, searching, adding,
# removing, and sending emails to records from a .csv dataset containing
# information about householders and their houses, including the householder's
# name, phone number and email address, and the house's energy rating (BER),
# address and year of construction.

source ./utils/colours.sh

./utils/print_logo.sh
sleep 3

# Displays all select options in one column
COLUMNS=0
menu_options=("View All Records" "Search Records" "Add Record"
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
        "Search Records")
            ./search/search.sh
            ;;
        "Add Record")
            ./add/add.sh
            ;;
        "Remove Record(s)")
            ./remove/remove.sh
            ;;
        "Email Householder(s)")
            ./email/email.sh
            ;;
        "Exit")
            echo -e "${COL_MSG}Goodbye!${COL_OFF}"
            sleep 1
            exit 0
            ;;
        *) 
            echo -e "${COL_ERR}\"${REPLY}\" is not a valid option${COL_OFF}"
            sleep 1.5
            ;;
        esac
        break
    done
done
