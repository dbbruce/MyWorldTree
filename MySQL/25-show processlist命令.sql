--查找MySQL中查询慢的SQL语句
--MySQL通过慢查询日志定位那些执行效率较低的SQL 语句，用--log-slow-queries[=file_name]选项启动时，
--mysqld 会写一个包含所有执行时间超过long_query_time 秒的SQL语句的日志文件，通过查看这个日志文件定位效率较低的SQL

一、配置选项可以帮助我们及时捕获低效SQL语句 (show variables like 'long_query_time';)
1.slow_query_log
这个参数设置为ON，可以捕获执行时间超过一定数值的SQL语句。

2.long_query_time
当SQL语句执行时间超过此数值时，就会被记录到日志中，建议设置为1或者更短。

3.slow_query_log_file
记录日志的文件名。

4.log_queries_not_using_indexes
这个参数设置为ON，可以捕获到所有未使用索引的SQL语句，尽管这个SQL语句有可能执行得挺快。

二、show processlist 命令
SHOW PROCESSLIST显示哪些线程正在运行
mysql> show processlist ;
+-----------+------+----------------------+------+---------+------+----------+------------------+-----------+---------------+
| Id        | User | Host                 | db   | Command | Time | State    | Info             | Rows_sent | Rows_examined |
+-----------+------+----------------------+------+---------+------+----------+------------------+-----------+---------------+
|      1154 | cmdb | 172.18.225.39:20977  | cmdb | Sleep   |   32 |          | NULL             |         0 |             0 |
|      1230 | cmdb | 172.18.225.39:21341  | cmdb | Sleep   |    6 |          | NULL             |         0 |             0 |
|  12702841 | cmdb | 172.18.225.39:47793  | cmdb | Sleep   |    6 |          | NULL             |         0 |             0 |
|  12703108 | cmdb | 172.18.225.39:48577  | cmdb | Sleep   |   66 |          | NULL             |         0 |             0 |
|  12703610 | cmdb | 172.18.225.39:50545  | cmdb | Sleep   |   44 |          | NULL             |         0 |             0 |
ID列
一个标识，你要kill一个语句的时候很有用，用命令杀掉此查询 /*/mysqladmin kill 进程号。

user列
显示单前用户，如果不是root，这个命令就只显示你权限范围内的sql语句。

host列
显示这个语句是从哪个ip的哪个端口上发出的。用于追踪出问题语句的用户。

db列
显示这个进程目前连接的是哪个数据库。

command列
显示当前连接的执行的命令，一般就是休眠（sleep），查询（query），连接（connect）。

time列
此这个状态持续的时间，单位是秒。

state列
显示使用当前连接的sql语句的状态，很重要的列，后续会有所有的状态的描述，请注意，state只是语句执行中的某一个状态，一个 sql语句，以查询为例，可能需要经过copying to tmp table，Sorting result，Sending data等状态才可以完成

info列
显示这个sql语句，因为长度有限，所以长的sql语句就显示不全，但是一个判断问题语句的重要依据。



三、下面我们单独看一下 Command 的值：

Binlog Dump: 主节点正在将二进制日志 ，同步到从节点
Change User: 正在执行一个 change-user 的操作
Close Stmt: 正在关闭一个Prepared Statement 对象
Connect: 一个从节点连上了主节点
Connect Out: 一个从节点正在连主节点
create DB: 正在执行一个create-database 的操作
Daemon: 服务器内部线程，而不是来自客户端的链接
Debug: 线程正在生成调试信息
Delayed insert: 该线程是一个延迟插入的处理程序
drop DB: 正在执行一个 drop-database 的操作
Execute: 正在执行一个 Prepared Statement
Fetch: 正在从Prepared Statement 中获取执行结果
Field List: 正在获取表的列信息
Init DB: 该线程正在选取一个默认的数据库
Kill : 正在执行 kill 语句，杀死指定线程
Long Data: 正在从Prepared Statement 中检索 long data
Ping: 正在处理 server-ping 的请求
Prepare: 该线程正在准备一个 Prepared Statement
ProcessList: 该线程正在生成服务器线程相关信息
Query: 该线程正在执行一个语句
Quit: 该线程正在退出
Refresh：该线程正在刷表，日志或缓存；或者在重置状态变量，或者在复制服务器信息
Register Slave： 正在注册从节点
Reset Stmt: 正在重置 prepared statement
Set Option: 正在设置或重置客户端的 statement-execution 选项
Shutdown: 正在关闭服务器
Sleep: 正在等待客户端向它发送执行语句
Statistics: 该线程正在生成 server-status 信息
Table Dump: 正在发送表的内容到从服务器