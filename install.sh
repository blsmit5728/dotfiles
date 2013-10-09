#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=`pwd`                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc screenrc colors"    # list of files/folders to symlink in homedir

##########
if [ $# -eq 0 ]
then
    echo "No Command Line Args Provided"
    echo "usage: ./install.sh <0 | 1>"
    echo " 0  : home use"
    echo " 1  : work use"
    exit
else
    if [ "$1" -eq "1" ]
    then
        echo "Work use selected, bashrc is being updated!!"
        sed -i 's/WORK=0/WORK=1/g' bashrc
    elif [ "$1" -eq "0" ]
    then
        echo "Home Use selected, bashrc was not updated."
    fi
fi

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

uname -a | grep Darwin --color=auto >> /dev/null 
if [ $? -eq "0" ]
then 
	# This is an OSX machine
    osx
else 
	# this is something else, not OSX
    ubuntu
fi



	
