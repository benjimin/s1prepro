#!/bin/env bash
#
# Preprocess many Sentinel 1 scenes using gpt
#

# For testing, try a random subset of the full input list:
# $   sort -R full.list | head > subset.list 

# For complete run:
# $ /usr/bin/time ./bulk.sh full.list | tee master.log


if [ "$#" != "1" ]; then # validate argument count
    echo Usage: . bulk.sh input_list.txt
else
    echo "Processing files listed in $1"


    date

    while read -r line; do
        short=$(echo $line | sed s:^.\*/:: | sed s:\.zip$::)

        echo $short

        . prepro.sh $line $short.dim > $short.log 2>&1

        [ -e $short.data ] && echo DONE || echo ABORT # check whether final output produced (not whether ok)
    done < $1

    date
fi
