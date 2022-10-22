#!/bin/bash
# Author: Eoin Fennessy
# Menu offering user options to search a specific field, search all fields or exit
# to main menu. If matching results are found they are displayed in a table which
# also displays the count of records found. Otherwise, a message saying "No
# matching records were found" is displayed. The script loops until user selects
# "Exit to Main Menu".

source ./search/search_by_field.sh
source ./search/search_all_fields.sh
source ./utils/colours.sh

function print_header {
    clear
    echo -e "${COL_HEAD}            Search Menu            ${COL_OFF}"
}

print_header
COLUMNS=0
PS3=$"${COL_PROMPT_PS3}Please enter your choice: ${COL_OFF_PS3}"
select opt in "Search by Field" \
              "Search all Fields" \
              "Exit to Main Menu"; do
    case $opt in
        "Search by Field")
            search_by_field
            break
            ;;
        "Search all Fields")
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

# Use search results variable set in previous step
if [[ $search_results ]]; then
    echo "$search_results" | ./utils/display_records_table.sh | less
else
    echo -e "${COL_MSG}No matching records were found${COL_OFF}"
    sleep 1.5
fi

./search/search.sh
