#!/bin/bash
# Author: Eoin Fennessy

source "./utils/get_valid_input.sh"

function search_by_field {
  PS3='Please enter your choice: '
  select opt in "Name" \
                "Eircode" \
                "Phone Number" \
                "Email Address" \
                "BER" \
                "Year of Construction" \
                "Exit to Main Menu"; do
    case $REPLY in
      [1-6])
        get_valid_input "$opt"
        search_results=$(awk -F, -v col="$REPLY" -v search_term="$input" \
          'BEGIN { IGNORECASE = 1 } $col == search_term' ber_details.csv)
        break
        ;;
      7)
        break 2
        ;;
      *) 
        echo "$REPLY is not a valid option"
        ;;
    esac
    REPLY=""
  done
}
