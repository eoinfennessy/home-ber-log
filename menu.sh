#!/bin/bash
# Author: Eoin Fennessy
# Description: Offers user options to view all employee records, enter an
# employee's name to see matching employees' wages, or exit the program.

# Displays all select options in one column
COLUMNS=0
PS3='Please enter your choice: '
select opt in "View All Records" \
              "Add Record" \
              "Search Records" \
              "Remove Record(s)" \
              "Email Householder(s)" \
              "Exit";do
  case $opt in
    "View All Records")
      cat ber_details.csv | ./utils/display_records_table.sh
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
      break
      ;;
    *) 
      echo "$REPLY is not a valid option"
      ;;
  esac
  # Setting REPLY to an empty string causes user options to be redisplayed
  REPLY=""
done
