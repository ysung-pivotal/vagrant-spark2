#!/bin/bash
source "/vagrant/scripts/common.sh"

function installJdk {
	echo "installing oracle jdk"
	FILE=/vagrant/resources/$JAVA_RPM
	rpm -ivh $FILE
}

function setupEnv {
	echo "creating java env variables"
	echo export JAVA_HOME=/usr/java/default > /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
}

if [ ! -f ~/jdk ]
then
	echo "setup jdk"
	installJdk
	setupEnv
	echo "setup jdk completed"
	touch ~/jdk
fi
