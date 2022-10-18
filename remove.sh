#!/bin/bash
# Author: Eoin Fennessy

source "./search/search_by_field.sh"
source "./search/search_all_fields.sh"
source "./utils/get_user_confirmation.sh"

COLUMNS=0
PS3='Please enter your choice: '
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
            echo "$REPLY is not a valid option"
            ;;
    esac
    REPLY=""
done

if [[ $search_results ]]; then
    echo "This will permanently remove the following records:"
    echo "$search_results" | ./utils/display_records_table.sh
    get_user_confirmation
    if [ $user_confirmation == "yes" ]; then
        echo "$search_results" \
            | tr '\n' '\0' \
            | xargs -0 -I {line} sed -ie "/{line}/d" ./ber_details.csv
    else
        echo "No records were deleted"
    fi
else
    echo "No matching records were found"
fi

./remove.sh
