#!/bin/bash

fil=/var/log/nginx/gitlab_access.log

#test for existence of the heyu log file
if [ -f $fil ]
then

  #read through the file looking for the word Temperature =

  while read line
  do
    echo $line | grep -q 192 
    if [ $? = 0 ]; then
    #mytemp=`echo $line  | cut -d = -f2 | cut -d : -f1`
    mytemp=`echo $line | awk '{print $1 }'`
    echo "Current temperature is: $mytemp"
    fi
  done < $fil

fi
