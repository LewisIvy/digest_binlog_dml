#!/bin/bash
dt=`date +%Y%m%d`
last_binlog_name_path=/data/mysqllog

binlog_name=`mysql -uuser -ppasswd -e"show master status " |grep bin |awk '{print $1}'|awk -F'.' '{printf $1"."; printf "%06d\n", $2}'`

if [ ! -f "$last_binlog_name_path/last_binlog_name.log" ]; then
        touch "$last_binlog_name_path/last_binlog_name.log"
        echo "binlog-name" >> $last_binlog_name_path/last_binlog_name.log
fi
last_binlog_name=`tail -1 $last_binlog_name_path/last_binlog_name.log`
if [ $last_binlog_name = $binlog_name ]; then
        echo "没有要分析的binlog！"
else
        echo "+-------+------------+---------`date +%Y%m%d%H%M%S` $binlog_name ------------+------+-------------+---------+" >> $last_binlog_name_path/$dt.Digest_Binlog.log;
        #mysqlbinlog --no-defaults -v -v /data/mysql/$binlog_name    |grep -E "UPDATE|INSERT|DELETE" |awk '{print $NF}' |sort  |uniq -c |sort -rn |head -100  
        mysqlbinlog --no-defaults -v -v /data/mysql/$binlog_name   |grep -E "UPDATE|INSERT|DELETE" |sort -t ' ' |uniq -c |sort -rn |head -100 >> $last_binlog_name_path/$dt.Digest_Binlog.log;
        echo $binlog_name >> $last_binlog_name_path/last_binlog_name.log;
fi
