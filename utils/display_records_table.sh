#!/bin/bash
# Author: Eoin Fennessy
# Display records in easily-readable tabular form. Count of records is also displayed.

awk -F, \
    'BEGIN {
        print "=================================================================================";
        print "Name            Eircode   Phone No.    Email                     BER   Year Built";
        print "================================================================================="
    }
    {
        printf "%-15s %-9s %-12s %-25s %-5s %-4s\n", $1, $2, $3, $4, $5, $6
    }
    END {
        print "=================================================================================";
        printf "A total of %s records were found\n", NR
        print "=================================================================================";
    }'
