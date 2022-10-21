#!/bin/bash
# Author: Eoin Fennessy
# Contains function to display menu offering various options to get a space-separated
# list of email recipients from the dataset and store them in the 
# "get_email_recipients" variable

source ./search/search_by_field.sh
source ./search/search_all_fields.sh

function print_header {
    clear
    echo -e "${COL_HEAD}            Email Householders            ${COL_OFF}"
}

function get_email_recipients {
    COLUMNS=0
    menu_options=("Email Householder(s) where Specified Field Matches Search Term"
                  "Email Householder(s) where Any Field Matches Search Term"
                  "Email All Householders"
                  "Exit to Main Menu")
    print_header
    PS3=$"${COL_PROMPT_PS3}Please enter your choice: ${COL_OFF_PS3}"
    select option in "${menu_options[@]}"; do
        case $option in
            "Email Householder(s) where Specified Field Matches Search Term")
                search_by_field
                break
                ;;
            "Email Householder(s) where Any Field Matches Search Term")
                search_all_fields
                break
                ;;
            "Email All Householders")
                # Add all records to search_results variable
                search_results=$(cat ber_details.csv)
                break
                ;;
            "Exit to Main Menu")
                exit 0
                ;;
            *)
                echo -e "${COL_ERR}\"${REPLY}\" is not a valid option${COL_OFF}"
                sleep 1.5
                print_header
                ;;
        esac
        REPLY=""
    done

    # Use search results set in previous step
    if [[ $search_results ]]; then
        clear
        echo "$search_results" | ./utils/display_records_table.sh
        echo -e "${COL_MSG}The above householders will be added as email recipients${COL_OFF}"
        get_user_confirmation
        if [ $user_confirmation == "yes" ]; then
            # Parse out email addresses and then convert newlines to spaces
            email_recipients=$(echo "$search_results" | cut -d',' -f4 | tr '\n' ' ')
        else
            get_email_recipients
            return
        fi
    else
        echo -e "${COL_MSG}No matching records were found${COL_OFF}"
        sleep 1.5
        get_email_recipients
    fi
}
