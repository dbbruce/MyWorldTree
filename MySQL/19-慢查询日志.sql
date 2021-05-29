1、慢查询日志
    指运行时间超过long_query_time值得SQL语句，则会被记录到慢日志中；

2、查看是否开启慢查询
    show variables like '%slow_query_log%';
    +---------------------------+----------------------------------+
    | Variable_name             | Value                            |
    +---------------------------+----------------------------------+
    | slow_query_log            | OFF                              |
    | slow_query_log_file       | /mysql/data/localhost-slow.log   |
    +---------------------------+----------------------------------+
3、查询慢日志阈值
    show variables like '%long_query_time%';
    +-----------------+-----------+
    | Variable_name   | Value     |
    +-----------------+-----------+
    | long_query_time | 10.000000 |
    +-----------------+-----------+

4、开启慢日志
     set global slow_query_log=1;
    show variables like 'slow_query%';
    +---------------------+------------------------------------------+
    | Variable_name       | Value                                    |
    +---------------------+------------------------------------------+
    | slow_query_log      | ON                                       |
    | slow_query_log_file | /usr/local/mysql/data/localhost-slow.log |
    +---------------------+------------------------------------------+

5、设置慢查询日志存放的位置
    set global slow_query_log_file='/usr/local/mysql/data/test-slow.log';

6、设置慢SQL时间(注意修改后，需要重新连接数据库，才能开到值生效)
    set global long_query_time=2;
    show variables like '%long_query_time%';
    +-----------------+----------+
    | Variable_name   | Value    |
    +-----------------+----------+
    | long_query_time | 2.000000 |
    +-----------------+----------+

7、修改配置文件
    [mysqld]
    slow_query_log = ON
    slow_query_log_file = /usr/local/mysql/data/slow.log
    long_query_time = 1

8、产生慢SQL日志，
    select sleep(3);

9、当前慢查询语句的个数
    show global status like "%slow_queries%";
    +---------------+-------+
    | Variable_name | Value |
    +---------------+-------+
    | Slow_queries  | 6     |
    +---------------+-------+

10、mysqldumpslow
    该工具是慢查询自带的分析慢查询工具
    参数：
        s:  按照何种方式排序
            c 访问次数
            l 锁定时间
            r 返回记录
            t 查询时间
            al 平均锁定时间
            ar 平均返回记录时间
            at 平均查询时间（默认）
        t: 返回前面多少条数据
        g: 后面搭配一个正则表达式，大小写不敏感
    # 取出使用最多的10条慢查询
    mysqldumpslow -s c -t 10 /var/run/mysqld/mysqld-slow.log
    # 取出查询时间最慢的3条慢查询
    mysqldumpslow -s t -t 3 /var/run/mysqld/mysqld-slow.log
    # 得到按照时间排序的前10条里面含有左连接的查询语句
    mysqldumpslow -s t -t 10 -g “left join” /database/mysql/slow-log
    # 按照扫描行数最多的
    mysqldumpslow -s r -t 10 -g 'left join' /var/run/mysqld/mysqld-slow.log



















