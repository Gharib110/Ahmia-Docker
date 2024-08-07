#!/bin/bash


for YEAR in {2018..2030}; do
  for MONTH in 01 02 03 04 05 06 07 08 09 10 11 12; do
    
    curl \
    -XPUT "${ES_URL}tor-$YEAR-$MONTH/" \
    -H 'Content-Type: application/json' -d "@./mappings_tor.json"

    echo ""
  done
done
