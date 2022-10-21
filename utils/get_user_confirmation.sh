#!/bin/bash
# Author: Eoin Fennessy
# Function to prompt user for confirmation. Sets "user_confirmation" variable
# to "yes" or "no"

function get_user_confirmation {
    echo -e -n "${COL_PROMPT}Do you wish to continue? (Y/n) ${COL_OFF}"
    read user_confirmation
    case $user_confirmation in
        [yY] | [yY][Ee][Ss] )
            user_confirmation="yes"
            ;;
        [nN] | [n|N][O|o] )
            user_confirmation="no"
            ;;
        *) 
            echo "Invalid input!"
            # Recursively call function until input is valid
            confirm
            ;;
    esac
}
