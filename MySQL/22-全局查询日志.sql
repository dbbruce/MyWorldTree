1、全局查询日志：永远不要在生产环境开启；

2、开启：
    set global general_log=1;
    set global log_output='TABLE';
    开启后，所有的sql都会记录在general_log表；

3、查看记录表
    select *  from mysql.general_log;
