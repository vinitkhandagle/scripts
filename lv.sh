#!/bin/bash

count=0
while [[ $count -lt 10 ]]
do
    echo -e "I \c"
    sleep 0.1
    echo -e "Love \c"
    sleep 0.1
    echo -e "U "
    sleep 0.1
    count="$count + 1"
done