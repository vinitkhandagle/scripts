##Script Name : Logfile Zipping files
##Purpose : To Zip log files and move them to a different directory
##Author : Vinit Khandagle
##Date : 28/08/2012 01:49:46 

#!/bin/bash

PS3='Please Select a choice: '
LIST="Directory_to_search Zip_log_files Move_to_Archive_folder Quit"

function display_disk_usage() {
	
	df_percent=`df -kh | awk '/\/$/ { print $5 }' | cut -c1,2`
	
	        if [ $df_percent -ge 90 ]
	                then
	                        echo "The disk is at $df_percent%: Please ensure you have sufficient space to zip the files"
	                        sleep 0.1
	                                exit
	                 elsenew/logfile1.log
	                        echo "SUFFICIENT DISK SPACE TO ZIPP THE FILES"
	        fi
                                	                        
}

select i in $LIST


do
	if [ "$i" = "Directory_to_search" ]
	then
		echo -n "Please enter the directory to search :" 
			read dirname
				echo "SEARCHING FOR *.LOG FILES IN THE $dirname"
					find $dirname -iname "*.log" -exec du -sh {} \; | sort -n -r

		elif [ $i = "Zip_log_files" ]
   			then
   			display_disk_usage
				echo -n "Please enter the Name path to the file to be zipped: "
				read filename
				echo "ZIPPING $filename WITH CURRENT DATE ATTACHED"
				gzip -c $filename > $filename.`date +%F`.gz
		
		elif [ "$i" = "Move_to_Archive_folder" ]
			then
				
				echo -n "Please specify the Archive folder Path :"
				read arcdir
				echo "MOVING TODAYS DATE GZIPPED FILES TO $arcdir"
					for files in `ls -A /home/linbynd/tests/new | egrep gz$`;do mv -v /home/linbynd/tests/new/$files $arcdir && sleep 0.05;done

			
		elif [ $i = "Quit" ]
			then
				echo "Exiting System Thank you"
				sleep 1
		exit 0
				
	fi

done
e
