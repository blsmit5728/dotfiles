#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=`pwd`                    
olddir=~/dotfiles_old 
files="bashrc vimrc screenrc colors" 

MY_DIR=`dirname $0`

source $MY_DIR/ubuntu/ubuntu_fresh_install.sh


function ubuntu {
	# create dotfiles_old in homedir
	echo "Creating $olddir for backup of any existing dotfiles in ~"
	mkdir -p $olddir
	echo "...done"

	# change to the dotfiles directory
	echo "Changing to the $dir directory"
	cd $dir
	echo "...done"

	# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
	for file in $files; do
    		echo "Moving any existing dotfiles from ~ to $olddir"
    		mv ~/.$file ~/dotfiles_old/
    		echo "Creating symlink to $file in home directory."
    		ln -s $dir/$file ~/.$file
	done
}

function osx {
	cp bash_profile_osx ~/.bash_profle
}

# Grep to see if we are on OSX or something else

uname -a | grep Darwin >> /dev/null 
if [ $? -eq "0" ]
then 
	# This is an OSX machine
    osx
else 
	# this is something else usually Ubuntu
    ubuntu
    if [ -d ~/.flexget ]
    then
        echo "Already setup for flexget"
    else
       	setup_ubuntu
    fi
fi



	
