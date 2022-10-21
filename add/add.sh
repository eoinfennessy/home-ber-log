#!/bin/bash
# Author: Eoin Fennessy
# User adds validated input for all record fields and is then offered options to
# store the record, amend any fields, or exit without saving. User is then given
# option to add another record or return to main menu.

source ./utils/colours.sh
source ./utils/get_valid_input.sh

function print_details_entered {
    clear
    echo -e "${COL_HEAD}        Details Entered        ${COL_OFF}"
    echo -e "${COL_MSG}Name:${COL_OFF}             $name"
    echo -e "${COL_MSG}Eircode:${COL_OFF}          $eircode"
    echo -e "${COL_MSG}Phone Number:${COL_OFF}     $phone_number"
    echo -e "${COL_MSG}Email Address:${COL_OFF}    $email_address"
    echo -e "${COL_MSG}BER:${COL_OFF}              $ber"
    echo -e "${COL_MSG}Year Constructed:${COL_OFF} $year"
    echo ""
}

function amend_record {
    clear
    PS3=$"${COL_PROMPT_PS3}Which record would you like to amend? ${COL_OFF_PS3}"
    select opt in "Name" \
                  "Eircode" \
                  "Phone Number" \
                  "Email Address" \
                  "BER" \
                  "Year of Construction" \
                  "Cancel"; do
        case $REPLY in
            [1-6])
                get_valid_input "$REPLY"
                break
                ;;
            7)
                break
                ;;
            *) 
                echo -e "${COL_ERR}$REPLY is not a valid option${COL_OFF}"
                ;;
        esac
        REPLY=""
    done
}

clear
echo -e "${COL_HEAD}            Add Record            ${COL_OFF}"

# Get input for each field from user
for i in {1..6}; do
    get_valid_input ${i}
done

print_details_entered

COLUMNS=0
PS3=$"${COL_PROMPT_PS3}What would you like to do? ${COL_OFF_PS3}"
select opt in "Store Record" \
              "Amend Record before Storing" \
              "Exit without Storing"; do
    case $opt in
        "Store Record")
            # Append comma-separated fields to ber_details.csv
            echo "$name,$eircode,$phone_number,$email_address,$ber,$year" \
                >> ber_details.csv
            break
            ;;
        "Amend Record before Storing")
            amend_record
            print_details_entered
            PS3=$"${COL_PROMPT_PS3}Please enter your choice of option: ${COL_OFF_PS3}"
            ;;
        "Exit without Storing")
            break
            ;;
        *)
            echo -e "${COL_ERR}$REPLY is not a valid option${COL_OFF}"
            ;;
    esac
    REPLY=""
done

clear
PS3=$"${COL_PROMPT_PS3}Would you like to add another record?: ${COL_OFF_PS3}"
select opt in "Yes" "No"; do
    case $opt in
        "Yes")
            ./add/add.sh
            break
            ;;
        "No")
            break
            ;;
        *) 
            clear
            echo -e "${COL_ERR}$REPLY is not a valid option${COL_OFF}"
            ;;
    esac
    REPLY=""
done
