#!/bin/bash
# Author: Eoin Fennessy

while [[ ! $input =~ ^[0-9A-Za-z" "\'-]+$ ]]; do
  echo "Please enter a search phrase:"
  read input
done

result=$(cat ber_details.csv | grep -i "${input}")
if [[ $result ]]; then
  echo "$result" | ./utils/display_records_table.sh
else
  echo "No matches found!"
fi
