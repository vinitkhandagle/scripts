##Script Name: catalog_ui_deploy.sh
##Purpose: Deploying UI for Catalog
##Author: Vinit Khandagle
##Date: 28/08/2012 21:22:03

#!/bin/bash




### Function to Completed the SVN checkout
### This function requires one parameter to be passed

svn_url=$1

function svn_checkout()
{
        echo "Executing SVN checkout of the code from repo \"$svn_url\""
        sleep 0.1
        svn checkout $svn_url $dir 2>&1 | tee svn.error
        if [ $? != 0 ]
                then
                    echo "SVN checkout failed cybage Please check the svn.error file"
                    exit
        fi

}

## Function to set the permissions recursively

function perm_set()
{
    if [ ! -d "$dir/$1" ]
        then
        echo "Creating the $dir/$1 directory"
        mkdir -p $dir/vi/tmp/lock
         chmod -R 777 $dir
    fi
    if [ $? != 0 ]
        then
            echo "Pemission setting has some errors, Please check"
            sleep 0.1
            exit
    fi
}

## Function to Execute Symbolic Links

function sym_link()
{

echo -e "Please enter the name of the user for whom the links should be created: \c"
read username
    ln_dst_family_assets=/data/longbow/legacy_catalog/images/product_family_assets
    ln_src_family_assets=/home/$username/$dir/images/product_family_assets
   
    ln_dst_logos=/data/longbow/legacy_catalog/images/logos
    ln_src_logos=/home/$username/$dir/images/logos
   
    ln_dst_wag_category=/data/longbow/legacy_catalog/images/wag_category
    ln_src_wag_category=/home/$username/$dir/images/wag_category
   
    ln_dst_wag_subcategory=/data/longbow/legacy_catalog/images/wag_subcategory
    ln_src_wag_subcategory=/home/$username/$dir/images/wag_subcategory
   
## Linking Family_assets directories
   
    if [ ! -d $ln_dst_family_assets ]
        then
            echo "Source directory \"$ln_dst_family_assets\" for linking does not exist"
             exit
        else
            echo "Creating Symlink for: $ln_dst_family_assets"
                sleep 0.05
            ln -sf $ln_dst_family_assets $ln_src_family_assets
    fi
    
## Linking Logo Directories
   
    if [ -d $ln_src_logos ]
        then
            rm -Rf $ln_src_logos
    fi
    
   
    if [ ! -d $ln_dst_logos ]
        then
            echo "The Source directory \"$ln_dst_logos\" for linking does not exist"
            exit
        else
            echo "Creating Symlink for: $ln_dst_logos"
                sleep 0.05
            ln -sf $ln_dst_logos $ln_src_logos
    fi
    
## Linking Wag_Category directories

    if [ ! -d $ln_dst_wag_category ]
        then
            echo "The Source directory \"$ln_dst_wag_category\" for linking does not exist"
            exit
        else
            echo "Creating Symlink for: $ln_dst_wag_category"
                sleep 0.05
            ln -sf $ln_dst_wag_category $ln_src_wag_category
    fi
   
## Linking Wag_Subdirectories directories
   
    if [ ! -d $ln_dst_wag_subcategory ]
        then
            echo "The Source directory \"$ln_dst_wag_subcategory\" for linking does not exist"
            exit
        else
            echo "Creating Symlink for: $ln_dst_wag_subcategory"
                sleep 0.05
            ln -sf $ln_dst_wag_subcategory $ln_src_wag_subcategory
    fi
}

## Function to update the Export / Import Directories

function exp_imp()
{

    user_dir=/home/$username/$dir/version1/reports
    ln_dst_exports=/data/longbow/mount/exports
    ln_src_exports=/home/$username/$dir/version1/reports/exports

    ln_dst_imports=/data/longbow/mount/imports
    ln_src_imports=/home/$username/$dir/version1/reports/imports


        echo "Updating Symlinks for exports and imports"
        sleep 2

        if [ -d $user_dir/$1 ]
            then
                echo "Deleting Directory: $user_dir/$1"         
                rm -rf $user_dir/$1
            else
                echo "Cannot Delete the Directory \"$user_dir/$1\" Please check"
                 exit
        fi
        
        if [ -d $user_dir/$2 ]
            then
                echo "Deleting Directory: $user_dir/$2"
                rm -rf $user_dir/$2
            else
                echo "Cannot Delete the Directory \"$user_dir/$1\" Please check"
                exit
        fi
        

        if [ ! -d $ln_dst_exports ]
                then
                    echo "The Source directory \"$ln_dst_exports\" for linking does not exist"
                    exit
                else
                    echo "Creating Symlink for: $ln_dst_exports"
                        sleep 0.05
                    ln -sf $ln_dst_exports $ln_src_exports
            fi


        if [ ! -d $ln_dst_imports ]
                then
                    echo "The Source directory \"$ln_dst_imports\" for linking does not exist"
                    exit
                else
                    echo "Creating Symlink for: $ln_dst_imports"
                        sleep 0.05
                    ln -sf $ln_dst_exports $ln_src_imports
        fi
}




## Main Code execution Block
## Runs the funstions that are defined Above

echo "########################################################################"
echo "UI Deployment Initiation: Points to Take Note While deployment"
echo "----------------------------------------------------------------"
echo "1. Please enter only the svn Url as the Parameter for the script"
echo "2. Please Run the script as root"
echo "3. Please Enter your Username when asked for after the SVN checkout"
echo "########################################################################"

    if [ $# = 0 ]
        then
            echo "Please Enter the SVN Url as the Parameter for the script"
            exit
    fi
       

        echo -e "Please Enter the Directory for deployment: \c"
        read dir
                if [ ! -d "$dir" ]
                        then
                                echo "creating the directory $dir"
                                mkdir -p $dir

                        else
                                echo "Deleting old deployed directory"
                                rm -rf $dir
                fi

svn_checkout
perm_set vi/tmp/lock
sym_link
exp_imp exports imports
chmod -R 777 $dir
sleep 5
echo "###############################"
echo "Catalog UI Deployment Completed"
echo "###############################"
sleep 4
exit
