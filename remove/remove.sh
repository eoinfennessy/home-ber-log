#!/bin/bash
# Author: Eoin Fennessy
# Offers users options to search for records to remove. Records are displayed
# to user before they are prompted to confirm their decision to permanetly
# remove the records. Message confirming the action that has been taken is then
# displayed before returning to the start of the script

source ./search/search_by_field.sh
source ./search/search_all_fields.sh
source ./utils/get_user_confirmation.sh
source ./utils/colours.sh

function print_header {
    clear
    echo -e "${COL_HEAD}            Remove Records            ${COL_OFF}"
}

print_header
COLUMNS=0
PS3=$"${COL_PROMPT_PS3}Please enter your choice: ${COL_OFF_PS3}"
select opt in "Remove record(s) where specified field matches search term" \
              "Remove record(s) where any field matches search term" \
              "Exit to Main Menu"; do
    case $opt in
        "Remove record(s) where specified field matches search term")
            search_by_field
            break
            ;;
        "Remove record(s) where any field matches search term")
            search_all_fields
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

clear
# Use search results set in previous step
if [[ $search_results ]]; then
    echo "$search_results" | ./utils/display_records_table.sh
    echo -e "${COL_WARN}WARNING: This will permanently remove the above records${COL_OFF}"
    get_user_confirmation
    if [ $user_confirmation == "yes" ]; then
        # Apply sed-delete to each matching line in records using xargs
        # Change newlines to nulls and split args on nulls instead of on whitespace
        echo "$search_results" \
            | tr '\n' '\0' \
            | xargs -0 -I {line} sed -i -e "/{line}/d" ./ber_details.csv
        record_count=$(echo "$search_results" | wc -l | tr -d ' ')
        echo -e "${COL_MSG}$record_count records were successfully deleted${COL_OFF}"
        sleep 1.5
    else
        echo -e "${COL_MSG}No records were deleted${COL_OFF}"
        sleep 1.5
    fi
else
    echo -e "${COL_MSG}No matching records were found!${COL_OFF}"
    sleep 1.5
fi

./remove/remove.sh
