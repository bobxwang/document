#!/bin/sh

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

#java虚拟机参数
JAVA_OPTS="-Xms2048m -Xmx2048m -XX:NewSize=384m -XX:MaxNewSize=450m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp"

APPDIR=/project/uapp
PIDFILE=$APPDIR/uapp.pid
if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE"); then
echo "uapp is already running ..."
exit 1
fi

nohup java $JAVA_OPTS -jar uapp.jar --spring.profiles.active=test >/dev/null 2>&1 &
echo $! > $PIDFILE
echo "start uapp success"