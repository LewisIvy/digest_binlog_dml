# digest_binlog_dml
统计上一个binlog排名前100的操作

1.设置每分钟执行一次，自动判断binlog是否被分析过。
2.输出结果:
+-------+------------+---------20150114170356 binlog1065.015435 ------------+------+-------------+---------+
  50002 ### DELETE FROM db1.tb2
  23848 ### UPDATE db5.tb1
    423 ### INSERT INTO db2.tb1
    203 ### UPDATE db3.tb2
    176 ### UPDATE db4.tb1
