#!/bin/bash
startmysqldb(){
#  ps -ef|grep cqdbmysql|grep -v grep|awk '{print $2}'|xargs kill -9
  ps -ef|grep data-table-mysql.jar|grep -v grep|awk '{print $2}'|xargs kill -9
  nohup java -XX:+UseG1GC -Xms7168m -Xmx7168m -Dserver.port=10014 -jar /opt/jar/data-table-mysql.jar >/dev/null 2>&1 &
}
#curl -s 10.248.27.210:10014/git-version
A=`curl -s --connect-timeout 5 -m 10  10.248.27.210:10014/git-version|awk -F ',' '{print $1}'|awk -F ':' '{print $2}'`
echo $A
if [ $A = true ];then
exit
else
echo `date +%Y%m%d%H%M%S` >>/root/restartmysql.log
  source /etc/profile
  startmysqldb
fi
