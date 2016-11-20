#!/bin/bash

#JAVA
JAVA_RPM=jdk-8u91-linux-x64.rpm

#HADOOP
HADOOP_TGZ=hadoop-2.7.3.tar.gz
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.7.3
HADOOP_RES_DIR=/vagrant/resources/hadoop

#HIVE
HIVE_VERSION=hive-2.1.0
HIVE_TGZ=apache-$HIVE_VERSION-bin.tar.gz
HIVE_RES_DIR=/vagrant/resources/hive
HIVE_CONF=/usr/local/hive/conf
HIVE_LIB_PATH=/usr/local/hive/lib
HIVE_MYSQL_JDBC=/vagrant/resources/mariadb-java-client-1.5.5.jar

#SPARK
SPARK_VERSION=spark-2.0.2
SPARK_TGZ=$SPARK_VERSION-bin-hadoop2.7.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF=/usr/local/spark/conf

SCALA_RPM=scala-2.12.0.rpm
