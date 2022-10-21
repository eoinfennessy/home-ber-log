#!/bin/bash
# Author: Eoin Fennessy
# Contains colour constants for app

# Reset
COL_OFF='\033[0m'

COL_HEAD='\033[44m'
COL_PROMPT='\033[38;05;42m'
COL_MSG='\033[38;05;5m'
COL_WARN='\033[38;05;220m'
COL_ERR='\033[38;05;202m'

# Logo colours
COL_BOLD_WHITE='\033[1;37m'
COL_LOGO_A='\033[38;2;44;101;22m'
COL_LOGO_B='\033[38;2;88;153;64m'
COL_LOGO_C='\033[38;2;132;186;108m'
COL_LOGO_D='\033[38;2;254;255;11m'
COL_LOGO_E='\033[38;2;250;190;7m'
COL_LOGO_F='\033[38;2;250;135;7m'
COL_LOGO_G='\033[38;2;250;67;6m'

# For use with PS3 prompt only
COL_OFF_PS3=$'\001\e[0m\002'
COL_PROMPT_PS3=$'\001\e[38;05;42m\002'
