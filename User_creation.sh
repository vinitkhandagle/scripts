##Script Name: user_creation.sh
##Purpose: To create User according to an enviornment
##Author: Vinit Khandagle


# Load text file lines into a bash array.
OLD_IFS=$IFS
IFS=':'
for line in $(cat "./userlist.txt"); do
    printf "${line}\n"
done
IFS=$OLD_IFS
