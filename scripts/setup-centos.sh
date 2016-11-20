#!/bin/bash

source "/vagrant/scripts/common.sh"

function disableFirewallD {
	systemctl disable firewalld
	systemctl stop firewalld
}

function setupUtilities {
	yum install -y mlocate mariadb-server mariadb epel-release
	updatedb
	systemctl enable mariadb
	systemctl start mariadb
	mysqladmin -u root password 'password'
}

function createSSHKey {
	echo "generating ssh key"
	ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
	cp -f /vagrant/resources/ssh/config ~/.ssh
}

function overwriteSSHCopyId {
	cp -f /vagrant/resources/ssh/ssh-copy-id.modified /usr/bin/ssh-copy-id
}

if [ ! -f ~/centos ]
then
	echo "setup centos..."
	disableFirewallD
	setupUtilities
	createSSHKey
	overwriteSSHCopyId
	touch ~/centos
	echo "setup centos completed"
fi
