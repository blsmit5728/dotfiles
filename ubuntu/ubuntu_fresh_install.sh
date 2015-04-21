#!/bin/bash

function setup_ubuntu {
    PACKAGES=""
    REPOS="repos"

    ARCH=`uname -m`
    X86_64="x86_64"
    X86="x86"
    ARM="armv7l"
    ARM_PI="armv6l"
    MY_DIR=`dirname $0`
    
    if [ -d ~/.ssh ]
    then
        echo "SSH Already Created"
    else
        ssh-keygen
    fi
    sudo add-apt-repository ppa:deluge-team/ppa
    sudo apt-get update
    sudo apt-get -y install \
        python-software-properties pkg-config software-properties-common \
        deluge deluge-web deluged python-setuptools git vim subversion screen tree \
        nmap munin munin-node apache2 
    # setup deluge 
    sudo cp $MY_DIR/deluge/default.deluge-daemon /etc/default/deluge-daemon
    sudo cp $MY_DIR/deluge/init.d.deluge-daemon /etc/init.d/deluge-daemon 
    sudo chmod 755 /etc/init.d/deluge-daemon
    sudo update-rc.d deluge-daemon defaults
    sudo invoke-rc.d deluge-daemon start
    sudo mkdir -p /var/log/deluge/daemon
    sudo mkdir /var/log/deluge/web
    sudo chmod -R 755 /var/log/deluge
    sudo chown -R bsmith /var/log/deluge
    sudo invoke-rc.d deluge-daemon restart
    # Install Flexget
    sudo easy_install pip
    sudo pip install flexget
    cd
    if [ -d /home/${USER}/repos/ ]
    then
        cd repos
    else
        mkdir -v /home/${USER}/repos/
        cd /home/${USER}/repos/
    fi
    git clone https://github.com/blsmit5728/flexget_files.git
    cd
    ln -s /home/bsmith/repos/flexget_files/ .flexget
}







