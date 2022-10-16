#!/bin/bash
# Author: Eoin Fennessy

awk -F, \
  'BEGIN {
    print "==========================================================================";
    print "Name            Eircode   Phone No.    Email                BER Year Built";
    print "=========================================================================="
  }
  {
    printf "%-15s %-9s %-12s %-20s %-3s %-4s\n", $1, $2, $3, $4, $5, $6
  }
  END {
    print "==========================================================================";
    printf "%s records found\n",
      NR
  }' \
  | less
