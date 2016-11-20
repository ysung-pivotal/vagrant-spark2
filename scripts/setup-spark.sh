#!/bin/bash

source "/vagrant/scripts/common.sh"

function installScala {
	echo "install scala from local file"
	FILE=/vagrant/resources/$SCALA_RPM
	rpm -ivh $FILE
}

function installR {
	yum -y install R
}

function installSpark {
	echo "install spark from local file"
	FILE=/vagrant/resources/$SPARK_TGZ
	tar -xzf $FILE -C /opt
	ln -s /opt/$SPARK_VERSION-bin-hadoop2.7 /usr/local/spark
	mkdir -p /usr/local/spark/logs/history
}

function setupSpark {
	echo "setup spark"
	cp -f /vagrant/resources/spark/slaves /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-env.sh /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-defaults.conf /usr/local/spark/conf
}

function setupEnvVars {
	echo "creating spark environment variables"
	cp -f $SPARK_RES_DIR/spark.sh /etc/profile.d/spark.sh
	. /etc/profile.d/spark.sh
}

function setupHistoryServer {
	echo "setup history server"
	. /etc/profile.d/hadoop.sh
    hdfs dfs -mkdir -p /user/spark/applicationHistory
    hdfs dfs -chmod -R 777 /user/spark
}

function startServices {
	echo "starting Spark history service"
	/usr/local/spark/sbin/start-history-server.sh
}

if [ ! -f ~/spark ]
then
	echo "setup spark"
	installScala
	installR
	installSpark
	setupSpark
	setupEnvVars
	setupHistoryServer
	startServices
	echo "spark setup complete"
	touch ~/spark
fi
