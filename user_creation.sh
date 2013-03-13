##Script Name: user_creation.sh
##Purpose: To create User according to an enviornment
##Author: Vinit Khandagle

NEW_USERS="userlist.txt"
SOLARIS_HOME="/exports/"
LINUX_HOME="/home/"
OLD_IFS=$IFS


function user_creation()
{
IFS=":"
    cat ${NEW_USERS} | \
        while read USER GECKOFIELD
            do
              useradd $USER -c $GECKOFIELD
              echo "Creating User $USER with the a comment field \"$GECKOFIELD......\""
              sleep 0.5
             
            done
IFS=$OLD_IFS
}

function home_dir()
{
    USERS=`cat userlist.txt | awk -F \: '{ print $1 }'`
    for i in $USERS
        do
            echo -n "Do you want to change the home directory for $i [Y|N]: "
            read ans
                if [ $ans != "Y" ] 
                then
                    echo "Please enter a \"Y\""
               
                 else
                        PS3='Please Select a Home Directory choice: '
                        LIST="Solaris Redhat"
                            select n in $LIST
                                do
                                    if [ $n = "Solaris" ]
                                        then
                                         echo "changing home directory to Solaris system...."
                                        break
                                    elif [ $n = "Redhat" ]
                                         then
                                            echo "changing home directory to Redhat system...."
                                          break
                                 
                                    fi
                                done
                                                         
                fi
                
                         
        done       
 }

#user_creation
home_dir
    

    
