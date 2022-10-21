#!/bin/bash
# Author: Eoin Fennessy
# Offers options to email householders. User first searches for householders to
# email or adds all houdeholders as recipients. Non-blank subject & body fileds
# are then inputted before being offered options to amend any details, send email,
# or exit without sending. User may then be taken back to the start of the script

source ./utils/get_user_confirmation.sh
source ./email/get_email_recipients.sh
source ./utils/colours.sh

function preview_email {
    clear
    echo -e "${COL_HEAD}              Email Review              ${COL_OFF}"
    echo -e "${COL_MSG}Recipients:${COL_OFF} $email_recipients"
    echo -e "${COL_MSG}Subject:${COL_OFF}    $subject"
    echo -e "${COL_MSG}Body:${COL_OFF}       $body"
    echo ""
}

function get_subject {
    echo -e "${COL_PROMPT}Enter email subject: ${COL_OFF}"
    read subject
    # If subject is null or contains only whitespace
    if [ ! $subject ]; then
        get_subject
    fi
}

function get_body {
    echo -e "${COL_PROMPT}Enter email body: ${COL_OFF}"
    read body
    # If body is null or contains only whitespace
    if [ ! $body ]; then
        get_body
    fi
}


get_email_recipients
get_subject
get_body

while true; do
    preview_email
    echo -e "${COL_MSG}Here are your options: ${COL_OFF}"
    PS3=$"${COL_PROMPT_PS3}What would you like to do? ${COL_OFF_PS3}"
    select option in "Send email" \
                     "Change email recipients" \
                     "Amend email subject" \
                     "Amend email body" \
                     "Exit to main menu without sending"; do
        case $option in
            "Send email")
                # Send email to the householder(s)
                echo "$body" | mail -s "$subject" "$email_recipients"
                echo -e "${COL_MSG}Email sent!${COL_OFF}"
                sleep 1.5
                exit 0
                ;;
            "Change email recipients")
                get_email_recipients
                ;;
            "Amend email subject")
                get_subject
                ;;
            "Amend email body")
                get_body
                ;;
            "Exit to main menu without sending")
                exit 0
                ;;
            *) 
                echo "$REPLY is not a valid option"
                ;;
        esac
        break
    done
done

./email/email.sh
