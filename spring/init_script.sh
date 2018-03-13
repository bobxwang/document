#!/bin/bash

#init test environment with jdk8, consul, service_java_jar

CONUSL_DOWNLOAD_URL="http://10.0.80.27/software/development/env_init/consul"
JDK8_DOWNLOAD_URL="http://10.0.80.27/software/development/jdk/x64/jdk-8u60-linux-x64.tar.gz"
SCRIPT_DOWNLOAD_URL="http://10.0.80.27/software/development/env_init/service_java_jar"

ipaddr=`/sbin/ifconfig -a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d "addr:"`
echo "IP address is ${ipaddr}"


function downloadJdk() {
	if curl --output /dev/null --silent --head --fail ${JDK8_DOWNLOAD_URL}; then
		curl -o /tmp/jdk-8u60-linux-x64.tar.gz ${JDK8_DOWNLOAD_URL} --silent
		tar zxf /tmp/jdk-8u60-linux-x64.tar.gz -C /usr/local/
		ln -s /usr/local/jdk1.8.0_60 /usr/local/java
		rm -f /tmp/jdk-8u60-linux-x64.tar.gz
		echo "export JAVA_HOME=/usr/local/java" >> ~/.bashrc
		echo 'export PATH=${JAVA_HOME}/bin:${PATH}' >> ~/.bashrc
		source ~/.bashrc
		echo "JDK download to /usr/local/java"
	else
		echo "ERROR: cannot find JDK at ${JDK8_DOWNLOAD_URL}"
	fi
}

function downloadScript() {
	[[ -d "/data/logs" ]] || mkdir -p /data/logs
	[[ -d "/data/apps" ]] || mkdir /data/apps
	[[ -d "/data/artifacts" ]] || mkdir /data/artifacts

	if curl --output /dev/null --silent --head --fail ${SCRIPT_DOWNLOAD_URL}; then
		curl -o /data/service_java_jar ${SCRIPT_DOWNLOAD_URL} --silent
		chmod 755 /data/service_java_jar
		echo "Script Downloaded at /data/service_java_jar"
	else
		echo "ERROR: cannot find script at ${SCRIPT_DOWNLOAD_URL}"
	fi
}

function downloadConsul() {
	consul=`whereis consul | awk '{print $2}'`
	if [ ${consul}X = "X" ]; then
		if curl --output /dev/null --silent --head --fail ${CONUSL_DOWNLOAD_URL}; then
			curl -o /usr/bin/consul ${CONUSL_DOWNLOAD_URL} --silent
			chmod 755 /usr/bin/consul
			echo "Consul downloaded consul at /usr/local/consul"
		else
			echo "ERROR: cannot find conusl at ${CONUSL_DOWNLOAD_URL}"
		fi
	else
		echo "consul already exist at ${consul}"
	fi

	consul_proc=`ps -ef | grep consul | grep -v grep | awk '{print $2}'`
	if [ ${consul_proc}X = "X" ]; then
		echo "start consul with: consul agent -data-dir /tmp/consul -node=${ipaddr} -bind=${ipaddr} -join=10.0.40.122 > /var/log/consul.log 2>&1 &"
		consul agent -data-dir /tmp/consul -node=${ipaddr} -bind=${ipaddr} -join=10.0.40.122 > /var/log/consul.log 2>&1 &
	else
		echo "consul already started with process ${consul_proc}"
	fi
}


downloadJdk
downloadScript
downloadConsul
echo "init finish"