#!/bin/bash

if ! ping ubuntu.com -c 1 > /dev/null 2>&1; then
	echo "Failed to ping ubuntu.com." >&2
	echo "A network connection is required to set up Ubuntu livecd." >&2
	exit 1
fi

# add universe, multiverse, and restricted repositories
echo "Adding universe, multiverse, and restricted repositories"
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

# update package list, and upgrade system
echo "Updating package list, and upgrade system"
sudo apt-get --yes update
sudo apt-get --yes upgrade

# install vim, git, vnc
echo "Installing vim, git, and vnc "
sudo apt-get --yes install vim
sudo apt-get --yes install git
sudo apt-get --yes install tigervnc-viewer

# install TeamViewer (for work-related purposes)
tv_url='https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
tv_loc="/tmp/teamviewer.deb"
if ! wget "$tv_url" -O "$tv_loc" -q --show-progress; then
	echo "Failed to download teamviewer." >&2
	exit 2
fi

sudo apt-get --yes install "$tv_loc"

rm "$tv_loc"