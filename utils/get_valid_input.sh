#!/bin/bash
# Author: Eoin Fennessy
# Contains various functions for getting valid input from the user

function get_valid_name {
    echo -e "${COL_PROMPT}Please enter the householder's name (first name and surname):${COL_OFF}"
    read name
    # Must start and end with letter; allow dashes, apostrophes and spaces inbetween
    # and require at least one space
    if [[ ! $name =~ ^[[:alpha:]]+[[:alpha:][:space:]\'-]*[[:space:]]+[[:alpha:][:space:]\'-]*[[:alpha:]]+$ ]]; then
        echo -e "${COL_ERR}$name is not a valid input!${COL_OFF}"
        get_valid_name
    fi
}

function get_valid_eircode {
    echo -e "${COL_PROMPT}Please enter Eircode (ABC 1234):${COL_OFF}"
    read eircode
    # Strip leading, trailing and intermediate whitespace and convert to uppercase
    eircode=$(echo "${eircode}" | tr -d '[:blank:]')
    eircode=$(echo "$eircode" | tr '[:lower:]' '[:upper:]')
    # Allow exactly seven alphanumeric characters only
    if [[ ! $eircode =~ ^[[:alnum:]]{7}$ ]]; then
        echo -e "${COL_ERR}$eircode is not a valid Eircode!${COL_OFF}"
        get_valid_eircode
    fi
}

function get_valid_phone_number {
    echo -e "${COL_PROMPT}Please enter phone number (08xxxxxxxx):${COL_OFF}"
    read phone_number
    # Strip leading, trailing and intermediate whitespace
    phone_number=$(echo "${phone_number}" | tr -d '[:blank:]')
    # Only allow ten numeric characters starting with "08"
    if [[ ! $phone_number =~ ^08[0-9]{8}$ ]]; then
        echo -e "${COL_ERR}$phone_number is not a valid phone number!${COL_OFF}"
        get_valid_phone_number
    fi
}

function get_valid_email_address {
    echo -e "${COL_PROMPT}Please enter email address:${COL_OFF}"
    read email_address
    # Allow x@x.y where x is any combination of letters, numbers, underscores,
    # dashes or dots, and y is any combination of letters and numbers.
    # TODO: This could definitely be improved
    if [[ ! $email_address =~ ^[[:alnum:]_.-]+@[[:alnum:]_.-]+\.[[:alnum:]]+$ ]]; then
        echo -e "${COL_ERR}$email_address is not a valid email address!${COL_OFF}"
        get_valid_email_address
    fi
}

function get_valid_ber {
    echo -e "${COL_PROMPT}Please enter BER (A-e):${COL_OFF}"
    read ber
    # Convert to uppercase
    ber=$(echo "$ber" | tr '[:lower:]' '[:upper:]')
    # Allow any uppercase letter from A to E
    if [[ ! $ber =~ ^[A-E]$ ]]; then
        echo -e "${COL_ERR}$ber is not a valid BER!${COL_OFF}"
        get_valid_ber
    fi
}

function get_valid_year {
    echo -e "${COL_PROMPT}Please enter year of construction (YYYY format):${COL_OFF}"
    read year
    # Allow four numbers starting with "1" or "2"
    if [[ ! $year =~ ^[1-2][0-9]{3}$ ]]; then
        echo -e "${COL_ERR}$year is not a valid year!${COL_OFF}"
        get_valid_ber
    fi
}

# Takes argument "$1" corresponding to field number. Calls corresponding function
# to get validated input for the specified field and sets "input" variable to
# the value the called function gets
function get_valid_input {
    case $1 in
        1)
            get_valid_name
            input=$name
            ;;
        2)
            get_valid_eircode
            input=$eircode
            ;;
        3)
            get_valid_phone_number
            input=$phone_number
            ;;
        4)
            get_valid_email_address
            input=$email_address
            ;;
        5)
            get_valid_ber
            input=$ber
            ;;
        6)
            get_valid_year
            input=$year
            ;;
        *) 
            echo "${COL_ERR}$1 is not a valid option${COL_OFF}" 1>&2
            exit 1
            ;;
    esac
}
