#!/bin/bash
# Author: Eoin Fennessy

source "./search/search_by_field.sh"

PS3='Please enter your choice: '
select opt in "Search by Field" \
              "Search Entire Record" \
              "Exit to Main Menu"; do
  case $opt in
    "Search by Field")
      search_by_field
      if [[ $search_results ]]; then
        echo "$search_results" | ./utils/display_records_table.sh | less
      else
        echo "Nothing found!"
      fi
      ;;
    "Search Entire Record")
      ./search/search_entire_record.sh
      ;;
    "Exit to Main Menu")
      break
      ;;
    *) 
      echo "$REPLY is not a valid option"
      ;;
  esac
  REPLY=""
done
    