#!/bin/bash

function setup_ubuntu {
	PACKAGES="git vim subversion screen tree"
	REPOS="repos"

    MY_DIR=`dirname $0`

	sudo apt-get -y install "$PACKAGES"
	if [ -d ~/.ssh ]
    then
        echo "SSH Already Created"
    else
        ssh-keygen
    fi
	sudo apt-get -y install python-software-properties pkg-config
	sudo apt-get -y install software-properties-common

	UBUNTU_BUILD=`cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -d'=' -f2`

	case "$UBUNTU_BUILD" in
		"saucy")
			echo "13.10"
			sudo add-apt-repository  ppa:team-xbmc/xbmc-nightly
			;;
		"percise")
			echo "12.04"
			sudo add-apt-repository ppa:team-xbmc/ppa
			;;
		*)
			echo "Version of Ubuntu unknown!!!"
			exit
			;;
	esac

	sudo apt-get update
	sudo apt-get -y install xbmc xbmc-bin
	sudo apt-get -y install deluge deluge-web deluged
	sudo cp $MY_DIR/deluge/deluge_default_script /etc/default/deluge-daemon
	sudo cp $MY_DIR/deluge/deluge_init_d_script /etc/init.d/deluge-daemon
	sudo chmod 755 /etc/init.d/deluge-daemon
	sudo update-rc.d deluge-daemon defaults
	sudo invoke-rc.d deluge-daemon start

	# Install Flexget
	sudo apt-get -y install python-setuptools
	sudo easy_install pip
	sudo pip install flexget
	# Setup Deluge Logging
	sudo mkdir -p /var/log/deluge/daemon
	sudo mkdir /var/log/deluge/web
	sudo chmod -R 755 /var/log/deluge
	sudo chown -R bsmith /var/log/deluge
	# restart deluge
	sudo invoke-rc.d deluge-daemon restart

	cd
	cd repos
	git clone https://github.com/blsmit5728/flexget_files.git
	cd
	ln -s /home/bsmith/repos/flexget_files/ .flexget
}

#cd
#cd repos
#git clone https://github.com/blsmit5728/dotfiles.git
#cd dotfiles
#./install.sh






