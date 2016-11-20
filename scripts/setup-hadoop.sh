#!/bin/bash

source "/vagrant/scripts/common.sh"

function installHadoop {
	echo "install hadoop from local file"
	FILE=/vagrant/resources/$HADOOP_TGZ
	tar zxvf $FILE -C /opt
	ln -s /opt/$HADOOP_VERSION /usr/local/hadoop
}

function setupHadoop {
	echo "creating hadoop dirs"
	mkdir -p /var/hadoop/hadoop-{datanode,namenode} /var/hadoop/mr-history/{done,tmp}
	echo "copying hadoop confs"
	cp -f $HADOOP_RES_DIR/* $HADOOP_CONF
}

function formatHdfs {
	echo "formatting HDFS"
	hdfs namenode -format
}

function startDaemons {
	/vagrant/scripts/start-hadoop.sh
}

function setupEnv {
	echo "creating hadoop env"
	cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
	. /etc/profile.d/hadoop.sh
}

function createHdfsDirs {
	echo "creating hdfs dirs"
	hdfs dfs -mkdir -p /user/root
	hdfs dfs -mkdir -p /user/vagrant
	hdfs dfs -chown vagrant /user/vagrant
	hdfs dfs -mkdir -p /tmp
	hdfs dfs -chmod -R 777 /tmp
	hdfs dfs -mkdir -p /var
	hdfs dfs -chmod -R 777 /var
}
if [ ! -f ~/hadoop ]
then
	echo "setting up hadoop"
	installHadoop
	setupHadoop
	setupEnv
	formatHdfs
	startDaemons
	createHdfsDirs
	echo "hadoop setup complete"
	touch ~/hadoop
fi
