## Script Name: user_checker.sh
## Purpose: Used to check if a user is a valid user on the system and has Sudo rights on the System as well
## Author: Vinit Khandagle
##Date: 23rd August 2012


####### PLEASE RUN THE SCRIPT WITH ROOT PRIVILEGES #######

group_check()
{
   usr_groups=`cat /etc/group | grep $1 | awk -F \: '{ print $1 }'`
   
    echo "Checking If the user belongs to any other groups"
    echo "---------------------------------------------------"
       echo "The User $1 is a part of the following groups :"
       echo "##############" 
       echo "$usr_groups"
   
       echo "##############"
       echo "Checking if the Groups have Sudo rights,"
       echo "---------------------------------------------------"
       for i in $usr_groups
       do 
       groups=$i
       grep -w $groups /etc/sudoers > /dev/null || grep -wE [%][@]$groups /etc/sudoers > /dev/null
            if [[ $? = 0 ]]
            then
                echo "Groups that the user Belongs to has Sudo rights"
            else
                echo "The User Nor the Group that the User belongs to has Sudo Rights on $HOSTNAME"
             fi
            
      done
       
}

#!/bin/bash

echo -e "Please enter the User Name: \c"
read username
	grep ^$username /etc/passwd > /dev/null

	if [ $? != 0 ]
		then
			echo "User does not exist on the System"
			exit
		else
			line=`grep ^$username /etc/passwd`
			IFS=:
			set $line
				echo "Username 	: $1"
				echo "User ID 	: $3"
				echo "Group ID 	: $4"
				echo "Comment Field 	: $5"
				echo "Home Folder 	: $6"
				echo "Login Shell 	: $7"

		echo "Checking if the user has Sudo Privileges"
		echo "-----------------------------------------"
		sleep 2
			grep ^$username /etc/sudoers > /dev/null
			if [ $? != 0 ]
				then
					echo "User does not have Sudo rights on $HOSTNAME"
					echo "-----------------------------------------"
					group_check $username
				else
					echo "User has sudo rights on $HOSTNAME"
					exit
			fi

	fi
	
	
	


