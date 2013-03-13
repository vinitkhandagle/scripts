##Script Name: Site Deploy
##Purpose: Deploying site
##Author: Vinit Khandagle
##Date:

#!/bin/bash

user_name=$1
site_doc=/var/www/site/

if [[ -d "code_dirs" ]]
        then
                rm -rf /home/$user_name/code_dirs
                echo "Deleting code_dirs directory and creating a new..."
                                sleep 0.05
                mkdir -p /home/$user_name/code_dirs
                                echo "Creating APP Directory..."
                                sleep 0.05
                                mkdir -p /home/$user_name/code_dirs/app/
                                echo "Creating CODE ETC and DESIGN directories.."
                                sleep 0.05
                                mkdir -p /home/$user_name/code_dirs/app/{code,etc,design}

        else
                echo "creating code_dirs directory..."
                                sleep 0.05
                mkdir -p /home/$user_name/code_dirs
                                echo "Creating APP Directory..."
                                sleep 0.05
                                mkdir -p /home/$user_name/code_dirs/app/
                                echo "Creating CODE ETC and DESIGN directories.."
                                sleep 0.05
                                mkdir -p /home/$user_name/code_dirs/app/{code,etc,design}
fi

echo "Copying local directory.."
sleep 0.5
cp -avRp $site_doc/app/code/local /home/$user_name/code_dirs/app/code/ 1>/dev/null
echo "Copying Community directory.."
sleep 0.5
cp -avRp $site_doc/app/code/community /home/$user_name/code_dirs/app/code/ 1>/dev/null
echo "Copying Design directory.."
sleep 0.5
cp -avRp $site_doc/app/design /home/$user_name/code_dirs/app/ 1>/dev/null
echo "Copying Modules directory.."
sleep 0.5
cp -avRp $site_doc/app/etc/modules /home/$user_name/code_dirs/app/etc/ 1>/dev/null
echo "Copying skin directory.."
sleep 0.5
cp -avRp $site_doc/skin /home/$user_name/code_dirs/ 1>/dev/null
echo "Copying JS directory.."
sleep 0.5
cp -avRp $site_doc/js /home/$user_name/code_dirs/ 1>/dev/null

echo "-----------------------"
echo "Coping Completed"
echo "-----------------------"

echo "Creating a Tar archive of the code_dirs"
sleep 0.5
        if [[ -f /home/$user_name/code_dirs.tar.gz ]]
                then
                        rm -rf /home/$user_name/code_dirs.tar.gz
                        cd /home/$user_name/
                        tar -czvf code_dirs.tar.gz code_dirs 1>/dev/null
                else
                        cd /home/$user_name/
                        tar -czvf code_dirs.tar.gz code_dirs 1>/dev/null
        fi


echo "-----------------------"
echo "TAR ARCHIVE CREATED"
echo "-----------------------"
echo "changing the permissions"
        chown -R $user_name:users /home/vinit/*

echo -n "Do you want to move to QA and production [Y|N]: "
read ans
	if [[ $ans = "Y" ]]
	then
		for i in x.q x.p.w1 x.p.w2 x.p.i;do /usr/bin/scp code_dirs.tar.gz $user_name@$i:;done
	else
		exit
	fi

