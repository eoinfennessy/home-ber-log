#!/bin/bash
# Author: Eoin Fennessy


function get_valid_name {
  name=""
  # Start and end with letter; allow dashes, apostrophes and spaces inbetween
  while [[ ! $name =~ ^[[:alpha:]]+[[:alpha:]' '-\']+[[:alpha:]]+$ ]]; do
    echo "Please enter a name:"
    read name
  done
}

function get_valid_eircode {
  eircode=""
  while [[ ! $eircode =~ ^[[:alnum:]]{7}$ ]]; do
    echo "Please enter Eircode (ABC ):"
    read eircode
    # Strip leading, trailing and intermediate whitespace and convert to uppercase
    eircode=$(echo "${eircode}" | tr -d '[:blank:]')
    eircode=$(echo "$eircode" | tr '[:lower:]' '[:upper:]')
  done
}

function get_valid_phone_number {
  phone_number=""
  while [[ ! $phone_number =~ ^08[0-9]{8}$ ]]; do
    echo "Please enter phone number (08xxxxxxxx):"
    read phone_number
    # Strip leading, trailing and intermediate whitespace
    phone_number=$(echo "${phone_number}" | tr -d '[:blank:]')
  done
}

function get_valid_email_address {
  email_address=""
  while [[ ! $email_address =~ ^[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]+$ ]]; do
    echo "Please enter email address:"
    read email_address
  done
}

function get_valid_ber {
  ber=""
  while [[ ! $ber =~ ^[A-E]$ ]]; do
    echo "Please enter BER (A-e):"
    read ber
    # Convert to uppercase
    ber=$(echo "$ber" | tr '[:lower:]' '[:upper:]')
  done
}

function get_valid_year {
  year=""
  while [[ ! $year =~ ^[1-2][0-9]{3}$ ]]; do
    echo "Please enter year of construction (YYYY format):"
    read year
  done
}

function get_valid_input {
  case $1 in
    "Name")
      get_valid_name
      input=$name
      ;;
    "Eircode")
      get_valid_eircode
      input=$eircode
      ;;
    "Phone Number")
      get_valid_phone_number
      input=$phone_number
      ;;
    "Email Address")
      get_valid_email_address
      input=$email_address
      ;;
    "BER")
      get_valid_ber
      input=$ber
      ;;
    "Year of Construction")
      get_valid_year
      input=$year
      ;;
    *) 
      echo "$1 is not a valid option" 1>&2
      exit 1
      ;;
  esac
}
