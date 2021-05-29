1、复制的基本原理
slave会从master读取binlog来进行数据同步

2、mysql复制过程分为3步
    1、master将改变记录到二进制日志（binary log）。这些记录过程叫做二进制日志事件，binary log events；
    2、slave将master的binary log events 拷贝到它的中继日志（relay log）;
    3、slave重做中继日志中的事件，将改变应用到自己的数据库中，MySQL复制是异步的切串行化的

3、复制的基本原则
    1、每个slave只有一个master
    2、每个slave只有一个唯一的服务器ID
    3、每个master可以游多个salve

4、复制的最大问题，延时

5、一主一从常见配置
    1、mysql版本一致，且后台已服务运行，ip需要通；
    2、主从都配置在[mysqld]结点下，都是小写 ;windows[mysql.ini] / linux[my.cnf]
        主机配置步骤：
        1、必须--主服务唯一ID --- server-id=1
        2、必须--启用二进制日志 --- log-bin=/xxx/mysqlbin ==>mysqlbin.201212
        3、可选--启用错误日志 --- log-err=/xxx/mysqlerr
        4、可选--根目录 --- basedir=/xxxx/
        5、可选--临时目录 --- tmpdir=/xxxx/
        6、可选--数据目录 --- datadir=/xxx/data/
        7、可选--主机,读写都可以 --- read-only=0 # 0代表读写都成
        8、可选--设置不要复制的数据库 --- binlog-ignore-db=mysql
        9、可选--设置需要复制的数据库 --- binlog-do-db=mysql

        从机配置步骤：
        1、必须--从服务器唯一ID --- server-id= 2
        2、可选--启用二进制日志 --- log-bin=mysql-bin

        注意修改过配置，mysql需要重启。
        service mysql stop
        service mysql start

        主机从机都要关闭防火墙
        service iptables stop

        主机上建立账号并授权slave
        grant replication slave on *.* to 'zhangsan'@'从机IP' identified by  '123456';
        flush privileges;

        查看主机状态
        show master status;
        记住，file和position，复制的文件和文件从哪里开始复制；这2个值，需要配置到从库
        +------------- ---+--------------+--------------+------------------+
        | File            | Position     | Binlog_Do_DB | Binlog_Ignore_DB |
        +------------- ---+--------------+--------------+------------------+
        | mysqlbin.000035 | 341          |              | mysql            |

        从机配置
        change master to master_hose = '192.168.xx.xx' master_user='zhangsan' master_password='123456'
        master_log_file= 'mysqlbin.000035', master_log_pos=341;

        查看从机状态
        show slave status;
        2个主要指标，这两个指标必须同时是yes才行，缺一个都失败
        Slave_IO_Running: Yes
        Slave_SQL_Running: Yes

6、从机停止复制
stop slave；











