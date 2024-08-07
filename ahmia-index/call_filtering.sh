#!/bin/bash

# We want to filter domains which are in this file
inputfile="filter_these_domains.txt"
inputfile_uniq="filter_these_domains_unique.txt"

python3 gather_from_index.py >> ${inputfile}

sort filter_these_domains.txt | uniq > ${inputfile_uniq}

cp $inputfile_uniq $inputfile

# Read line by line
while read domain; do
    if [ ! -z "$domain" ]; then
        if [[ ${#domain} -gt 50 ]] ; then
            python3 filter_onions.py $domain
            sleep 0.01
            python3 filter_onions.py $domain
        fi
    fi
done < ${inputfile_uniq}
