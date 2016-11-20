#!/bin/bash

source "/vagrant/scripts/common.sh"

function installHive {
	echo "install hive from local file"
	FILE=/vagrant/resources/$HIVE_TGZ
	tar -xzf $FILE -C /opt
	ln -s /opt/apache-$HIVE_VERSION-bin /usr/local/hive
	mkdir /usr/local/hive/{logs,derby}
}

function setupHive {
	echo "copying over hive configuration file"
	cp -f $HIVE_RES_DIR/* $HIVE_CONF
	cp -f $HIVE_MYSQL_JDBC $HIVE_LIB_PATH
	mysql -u root -ppassword -e "create user 'hive'@localhost identified by 'password';"
	mysql -u root -ppassword -e "grant all on *.* to 'hive'@localhost identified by 'password';"
	mysql -u root -ppassword -e "flush privileges;"
	/usr/local/hive/bin/schematool -initSchema -dbType mysql
}

function setupEnvVars {
	echo "creating hive environment variables"
	cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
	. /etc/profile.d/hive.sh
}

function runHiveServices {
	echo "running hive metastore"
    nohup hive --service metastore < /dev/null > /usr/local/hive/logs/hive_metastore_`date +"%Y%m%d%H%M%S"`.log 2>&1 &

	echo "running hive server2"
    nohup hive --service hiveserver2 < /dev/null > /usr/local/hive/logs/hive_server2_`date +"%Y%m%d%H%M%S"`.log 2>&1 &
}

if [ ! -f ~/hive ]
then
	echo "setup hive"
	installHive
	setupHive
	setupEnvVars
	runHiveServices
	echo "hive setup complete"
	touch ~/hive
fi
