#!/bin/bash
# Author: Eoin Fennessy
# User selects a field to search and then provides validated input for searching
# the field. The column for that field is then searched for an exact match (ignoring
# case) and the results are stored in the variable "search_results".

source ./utils/get_valid_input.sh

function search_by_field {
    clear
    echo -e "${COL_HEAD}          Select Field          ${COL_OFF}"
    PS3=$"${COL_PROMPT_PS3}Please enter your choice: ${COL_OFF_PS3}"
    select opt in "Name" \
                  "Eircode" \
                  "Phone Number" \
                  "Email Address" \
                  "BER" \
                  "Year of Construction" \
                  "Exit to Main Menu"; do
        case $REPLY in
        [1-6])
            # Gets "input" variable containing validated search term for selected field
            get_valid_input "$REPLY"
            # Search selected field for exact match (ignoring case)
            # and store results in "search_results"
            search_results=$(awk -F, -v col="$REPLY" -v search_term="$input" \
            'tolower($col) == tolower(search_term)' ber_details.csv)
            break
            ;;
        7)
            exit 0
            ;;
        *) 
            echo "$REPLY is not a valid option"
            ;;
        esac
        REPLY=""
    done
}
