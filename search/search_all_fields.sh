#!/bin/bash
# Author: Eoin Fennessy
# Takes input from user until it is valid (empty/whitespace-only input and
# input containing commas not allowed) then searches all fields in all records
# for (partial) match of search term (ignoring case). Search results are then
# stored in variable "search_results"

function search_all_fields {
    echo -e "${COL_PROMPT}Please enter a search phrase: ${COL_OFF}"
    read input
    if [ ! $input ]; then
        echo -e "${COL_ERR}Invalid input: Search term is empty or contains only whitespace${COL_OFF}"
        search_all_fields
        return
    elif [[ $input =~ ,+ ]]; then
        echo -e "${COL_ERR}Invalid input: Search terms should not include commas${COL_OFF}"
        search_all_fields
        return
    fi

    # Search all records for partial match of search term (ignoring case) and
    # store results in "search_results" variable
    search_results=$(grep -i "$input" ber_details.csv)
}
