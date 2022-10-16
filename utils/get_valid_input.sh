#!/bin/bash
# Author: Eoin Fennessy


function get_valid_name {
  name=""
  while [[ ! $name =~ ^[A-Za-z]+[[:blank:]][A-Za-z]+$ ]]; do
    echo "Please enter a name:"
    read name
  done
}


function get_valid_ber {
  ber=""
  while [[ ! $ber =~ ^[A-Za-z]$ ]]; do
    echo "Please enter BER:"
    read ber
  done
}


function get_valid_input {
  case $1 in
    "Name")
      get_valid_name
      input=$name
      ;;
    "Eircode")
      echo "Eircode"
      ;;
    "Phone Number")
      echo "Phone Number"
      ;;
    "Email Address")
      echo "Email Address"
      ;;
    "BER")
      get_valid_ber
      input=$ber
      ;;
    "Year of Construction")
      echo "Year of Construction"
      ;;
    *) 
      echo "$1 is not a valid option" 1>&2
      exit 1
      ;;
  esac
}
