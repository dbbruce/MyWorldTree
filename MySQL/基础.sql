1、设置密码：
    mysqladmin -uroot -p password "123"

2、修改密码：
    mysqladmin -uroot -p123 password "123456"  # 123为旧密码

3、mysql密码忘记，重置
    1、跳过授权表；关闭mysql，使用mysqld_safe重启,重置密码
    service mysqld stop
    mysqld_safe --skip-grant-tables
    mysql -uroot -p
    update mysql.user set password=password("") where user="root" and host="localhost";
    flush privileges;

4、查看mysql编码信息 ，进入mysql后输入 "\s"

    cmdb@192.168.1.57 09:44:  [cmdb_qa]> \s
    --------------
    mysql  Ver 14.14 Distrib 5.7.16-10, for Linux (x86_64) using  6.2

    Connection id:          8123615
    Current database:       cmdb_qa
    Current user:           cmdb@192.168.1.57
    SSL:                    Cipher in use is ECDHE-RSA-AES128-GCM-SHA256
    Current pager:          stdout
    Using outfile:          ''
    Using delimiter:        ;
    Server version:         5.7.24-27-log Percona Server (GPL), Release 27, Revision bd42700
    Protocol version:       10
    Connection:             192.168.1.57 via TCP/IP
    Server characterset:    utf8mb4
    Db     characterset:    utf8mb4
    Client characterset:    utf8mb4
    Conn.  characterset:    utf8mb4
    TCP port:               3306
    Uptime:                 42 days 17 hours 41 min 32 sec

    Threads: 1  Questions: 136685722  Slow queries: 83  Opens: 86839  Flush tables: 1  Open tables: 1976  Queries per second avg: 37.017

5、查看当前数据库使用的编码
    show variables like 'char%';

6、修改数据库编码
    在[mysqld]下添加
    default-character-set=utf8
    在[client]下添加
    default-character-set=utf8

7、创建数据库
    CREATE DATABASE `mydb` CHARACTER SET utf8 COLLATE utf8_general_ci;

8、删除数据库
    drop database <数据库名>;

9、创建表
    CREATE TABLE IF NOT EXISTS `runoob_tbl`(
       `runoob_id` INT UNSIGNED AUTO_INCREMENT COMMENT '主键ID',
       `runoob_title` VARCHAR(100) NOT NULL,
       `runoob_author` VARCHAR(40) NOT NULL,
       `submission_date` DATE,
       PRIMARY KEY ( `runoob_id` )
    )ENGINE=InnoDB DEFAULT CHARSET=utf8;

10、删除表
    DROP TABLE table_name ;

11、插入数据
    INSERT INTO runoob_tbl(runoob_title, runoob_author, submission_date) VALUES("学习 PHP", "菜鸟教程", NOW());

12、更新数据
    UPDATE table_name SET field1=new-value1, field2=new-value2 [WHERE Clause]

13、UNION 操作符(数据表上线联合),MySQL UNION 操作符用于连接两个以上的 SELECT 语句的结果组合到一个结果集合中。多个 SELECT 语句会删除重复的数据。
    SELECT country FROM Websites
    UNION
    SELECT country FROM apps
    ORDER BY country;

    SELECT country, name FROM Websites
    WHERE country='CN'
    UNION ALL
    SELECT country, app_name FROM apps
    WHERE country='CN'
    ORDER BY country;

14、WITH ROLLUP 可以实现在分组统计数据基础上再进行相同的统计
    SELECT name, SUM(singin) as singin_count FROM  employee_tbl GROUP BY name WITH ROLLUP;
        +--------+--------------+
        | name   | singin_count |
        +--------+--------------+
        | 小丽 |            2 |
        | 小明 |            7 |
        | 小王 |            7 |
        | NULL   |           16 |
        +--------+--------------+
        4 rows in set (0.00 sec)

15、coalesce 来设置一个可以取代 NUll 的名称，coalesce 语法：
    select coalesce(a,b,c);
    参数说明：如果a==null,则选择b；如果b==null,则选择c；如果a!=null,则选择a；如果a b c 都为null ，则返回为null（没意义
    SELECT coalesce(name, '总数'), SUM(singin) as singin_count FROM  employee_tbl GROUP BY name WITH ROLLUP;
        +--------------------------+--------------+
        | coalesce(name, '总数') | singin_count |
        +--------------------------+--------------+
        | 小丽                   |            2 |
        | 小明                   |            7 |
        | 小王                   |            7 |
        | 总数                   |           16 |
        +--------------------------+--------------+
        4 rows in set (0.01 sec)

16、MySQL 连接的使用
    INNER JOIN（内连接,或等值连接）：获取两个表中字段匹配关系的记录。   注意： 可以是WHERE或者ON设置，过滤条件；
    LEFT JOIN（左连接）：获取左表所有记录，即使右表没有对应匹配的记录。  注意:  过滤只能用ON
    RIGHT JOIN（右连接）： 与 LEFT JOIN 相反，用于获取右表所有记录，即使左表没有对应匹配的记录。   注意:  过滤只能用ON

    实例：
        SELECT
            a.runoob_id,
            a.runoob_author,
            b.runoob_count
        FROM
            runoob_tbl a
        INNER JOIN/RIGHT JOIN/LEFT JOIN
            tcount_tbl b on a.runoob_author = b.runoob_author;


17、NULL 值处理
    IS NULL: 当列的值是 NULL,此运算符返回 true。
    IS NOT NULL: 当列的值不为 NULL, 运算符返回 true。
    <=>: 比较操作符（不同于 = 运算符），当比较的的两个值相等或者都为 NULL 时返回 true。

18、正则表达式
    过 LIKE ...% 来进行模糊匹配
    ^	        匹配输入字符串的开始位置。如果设置了 RegExp 对象的 Multiline 属性，^ 也匹配 '\n' 或 '\r' 之后的位置。
    $	        匹配输入字符串的结束位置。如果设置了RegExp 对象的 Multiline 属性，$ 也匹配 '\n' 或 '\r' 之前的位置。
    .	        匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用像 '[.\n]' 的模式。
    [...]	    字符集合。匹配所包含的任意一个字符。例如， '[abc]' 可以匹配 "plain" 中的 'a'。
    [^...]	    负值字符集合。匹配未包含的任意字符。例如， '[^abc]' 可以匹配 "plain" 中的'p'。
    p1|p2|p3	匹配 p1 或 p2 或 p3。例如，'z|food' 能匹配 "z" 或 "food"。'(z|f)ood' 则匹配 "zood" 或 "food"。
    *	        匹配前面的子表达式零次或多次。例如，zo* 能匹配 "z" 以及 "zoo"。* 等价于{0,}。
    +	        匹配前面的子表达式一次或多次。例如，'zo+' 能匹配 "zo" 以及 "zoo"，但不能匹配 "z"。+ 等价于 {1,}。
    {n}	        n 是一个非负整数。匹配确定的 n 次。例如，'o{2}' 不能匹配 "Bob" 中的 'o'，但是能匹配 "food" 中的两个 o。
    {n,m}	    m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次。

19、MySQL 事务
    MySQL 事务主要用于处理操作量大，复杂度高的数据
    1、在 MySQL 中只有使用了 Innodb 数据库引擎的数据库或表才支持事务。
    2、事务处理可以用来维护数据库的完整性，保证成批的 SQL 语句要么全部执行，要么全部不执行。
    3、事务用来管理 insert,update,delete 语句

    事务控制语句：
    BEGIN 或 START TRANSACTION 显式地开启一个事务；
    COMMIT 也可以使用 COMMIT WORK，不过二者是等价的。COMMIT 会提交事务，并使已对数据库进行的所有修改成为永久性的；
    ROLLBACK 也可以使用 ROLLBACK WORK，不过二者是等价的。回滚会结束用户的事务，并撤销正在进行的所有未提交的修改；
    SAVEPOINT identifier，SAVEPOINT 允许在事务中创建一个保存点，一个事务中可以有多个 SAVEPOINT；
    RELEASE SAVEPOINT identifier 删除一个事务的保存点，当没有指定的保存点时，执行该语句会抛出一个异常；
    ROLLBACK TO identifier 把事务回滚到标记点；
    SET TRANSACTION 用来设置事务的隔离级别。InnoDB 存储引擎提供事务的隔离级别有READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ 和 SERIALIZABLE。

    MYSQL 事务处理主要有两种方法：
    1、用 BEGIN, ROLLBACK, COMMIT来实现
    BEGIN 开始一个事务
    ROLLBACK 事务回滚
    COMMIT 事务确认

    2、直接用 SET 来改变 MySQL 的自动提交模式:
    SET AUTOCOMMIT=0 禁止自动提交
    SET AUTOCOMMIT=1 开启自动提交
    实例1：
    begin;
    insert into runoob_transaction_test value(5);
    insert into runoob_transaction_test value(6);
    commit;
    实例2：
    begin;
    insert into runoob_transaction_test values(7);
    ROLLBACK

20、ALTER命令
    添加
    ALTER TABLE testalter_tbl ADD i INT;
    ALTER TABLE testalter_tbl ADD i INT FIRST;修改
    ALTER TABLE testalter_tbl ADD i INT AFTER c;

    删除
    ALTER TABLE testalter_tbl DROP i;
    ALTER TABLE testalter_tbl DROP i;

    修改
    ALTER TABLE testalter_tbl MODIFY c CHAR(10);
    在 CHANGE 关键字之后，紧跟着的是你要修改的字段名，然后指定新字段名及类型
    ALTER TABLE testalter_tbl CHANGE i j BIGINT;
    ALTER TABLE testalter_tbl CHANGE j j INT;
    ALTER TABLE testalter_tbl MODIFY j BIGINT NOT NULL DEFAULT 100;  修改设置默认值
    ALTER TABLE testalter_tbl ALTER i SET DEFAULT 1000; 设置默认值
    ALTER TABLE testalter_tbl ALTER i DROP DEFAULT;  删除默认值

21、修改数据表类型--引擎修改
    ALTER TABLE testalter_tbl ENGINE = MYISAM;

22、查看数据表类型
    SHOW TABLE STATUS LIKE 'testalter_tbl'

23、修改表名
    ALTER TABLE testalter_tbl RENAME TO alter_tbl;

24、MySQL 索引
    MySQL索引的建立对于MySQL的高效运行是很重要的，索引可以大大提高MySQL的检索速度
    创建索引时，你需要确保该索引是应用在 SQL 查询语句的条件(一般作为 WHERE 子句的条件)。
    1、显示索引信
        SHOW INDEX FROM table_name;
    2、创建索引
        CREATE INDEX indexName ON table_name (column_name)
    3、修改表结构(添加索引)
        ALTER table tableName ADD INDEX indexName(columnName)
    4、创建表的时候直接指定
        CREATE TABLE mytable(
            ID INT NOT NULL,
            username VARCHAR(16) NOT NULL,
            INDEX [indexName] (username(length))
        );
    5、删除索引的语法
        DROP INDEX [indexName] ON mytable;

25、唯一索引
    它与前面的普通索引类似，不同的就是：索引列的值必须唯一，但允许有空值。如果是组合索引，则列值的组合必须唯一
    1、创建索引
        CREATE UNIQUE INDEX indexName ON mytable(username(length))
    2、修改表结构
        ALTER table mytable ADD UNIQUE [indexName] (username(length))
    3、创建表的时候直接指定
        CREATE TABLE mytable(
        ID INT NOT NULL,
        username VARCHAR(16) NOT NULL,
        UNIQUE [indexName] (username(length))
        );

26、使用ALTER 命令添加和删除索引
    有四种方式来添加数据表的索引：
    ALTER TABLE tbl_name ADD PRIMARY KEY (column_list): 该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。
    ALTER TABLE tbl_name ADD UNIQUE index_name (column_list): 这条语句创建索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。
    ALTER TABLE tbl_name ADD INDEX index_name (column_list): 添加普通索引，索引值可出现多次。
    ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list):该语句指定了索引为 FULLTEXT ，用于全文索引。

27、MySQL 临时表 (使用 SHOW TABLES命令显示数据表列表时，你将无法看到临时表)
    MySQL 临时表在我们需要保存一些临时数据时是非常有用的。临时表只在当前连接可见，当关闭连接时，Mysql会自动删除表并释放所有空间。
    CREATE TEMPORARY TABLE SalesSummary (
        product_name VARCHAR(50) NOT NULL
        , total_sales DECIMAL(12,2) NOT NULL DEFAULT 0.00
        , avg_unit_price DECIMAL(7,2) NOT NULL DEFAULT 0.00
        , total_units_sold INT UNSIGNED NOT NULL DEFAULT 0
    );

28、删除MySQL 临时表
    DROP TABLE SalesSummary;

29、MySQL 复制表
    如果你想复制表的内容，你就可以使用 INSERT INTO ... SELECT 语句来实现。
    INSERT INTO clone_tbl (runoob_id, runoob_title, runoob_author, submission_date)
    SELECT runoob_id,runoob_title, runoob_author,submission_date FROM runoob_tbl;

30、MySQL 元数据
    你可能想知道MySQL以下三种信息：
        查询结果信息： SELECT, UPDATE 或 DELETE语句影响的记录数。
        数据库和数据表的信息： 包含了数据库及数据表的结构信息。
        MySQL服务器信息： 包含了数据库服务器的当前状态，版本号等。
    获取服务器元数据
        SELECT VERSION( )	服务器版本信息
        SELECT DATABASE( )	当前数据库名 (或者返回空)
        SELECT USER( )	当前用户名
        SHOW STATUS	服务器状态
        SHOW VARIABLES	服务器配置变量

31、使用 AUTO_INCREMENT
    CREATE TABLE insect
        -> (
        -> id INT UNSIGNED NOT NULL AUTO_INCREMENT,
        -> PRIMARY KEY (id),
        -> name VARCHAR(30) NOT NULL, # type of insect
        -> date DATE NOT NULL, # date collected
        -> origin VARCHAR(30) NOT NULL # where collected
    );

32、设置序列的开始值
    ALTER TABLE t AUTO_INCREMENT = 100;

33、防止表中出现重复数据
    INSERT IGNORE INTO 与 INSERT INTO 的区别就是 INSERT IGNORE INTO 会忽略数据库中已经存在的数据，
    如果数据库没有数据，就插入新的数据，如果有数据的话就跳过这条数据。这样就可以保留数据库中已经存在数据，达到在间隙中插入数据的目的。
    1、设置字段唯一性；设置表中字段 first_name，last_name 数据不能重复，你可以设置双主键模式来设置数据的唯一性
        CREATE TABLE person_tbl
        (
           first_name CHAR(20) NOT NULL,
           last_name CHAR(20) NOT NULL,
           sex CHAR(10),
           PRIMARY KEY (last_name, first_name)
        );
    2、使用 insert ignore into，忽略错误
        INSERT IGNORE INTO person_tbl (last_name, first_name) VALUES( 'Jay', 'Thomas');

34、Mysql中HAVING的相关使用方法
    having字句可以让我们筛选分组之后的各种数据，where字句在聚合前先筛选记录，也就是说作用在group by和having字句前。
    而having子句在聚合后对组记录进行筛选。我的理解就是真实表中没有此数据，这些数据是通过一些函数产生的。
    一、显示每个地区的总人口数和总面积．
        SELECT region, SUM(population), SUM(area) FROM bbc GROUP BY region
        先以region把返回记录分成多个组，这就是GROUP BY的字面含义。分完组后，然后用聚合函数对每组中
        的不同字段（一或多条记录）作运算。
    二、 显示每个地区的总人口数和总面积．仅显示那些面积超过1000000的地区。
        SELECT region, SUM(population), SUM(area)
        FROM bbc
        GROUP BY region
        HAVING SUM(area)>1000000
        在这里，我们不能用where来筛选超过1000000的地区，因为表中不存在这样一条记录。
        相反，having子句可以让我们筛选分组后的各组数据
    三、 having单独使用，与where类似
        eg: 查询单笔订单充值金额大于1000的
        SELECT regagent,amount FROM `cy_pay_ok`  having amount>1000 ;
        SELECT regagent,amount FROM `cy_pay_ok`  where amount>1000 ;
        两个查询结果一样

35、统计重复数据
    select count(*) as repetitions,last_name, first_name from person_tbl
    group by last_name, first_name having repetitions > 1;

36、过滤重复数据
    select distinct last_name, first_name from person_tbl;

37、删除重复数据
    1、创建临时表，将去重后的数据写入
        CREATE TABLE tmp SELECT last_name, first_name, sex FROM person_tbl  GROUP BY (last_name, first_name, sex);
    2、删除旧表
        DROP TABLE person_tbl;
    3、修改表名
        ALTER TABLE tmp RENAME TO person_tbl;

38、修改表名
rename命令格式：rename table 原表名 to 新表名;

39、secure_file_priv
    mysql> show global variables like '%secure_file_priv%';
    +------------------+-------+
    | Variable_name    | Value |
    +------------------+-------+
    | secure_file_priv | NULL  |
    +------------------+-------+
    secure_file_priv 为 NULL 时，表示限制mysqld不允许导入或导出。
    secure_file_priv 为 /tmp 时，表示限制mysqld只能在/tmp目录中执行导入导出，其他目录不能执行。
    secure_file_priv 没有值时，表示不限制mysqld在任意目录的导入导出

    打开my.cnf 或 my.ini，加入以下语句后重启mysql。
    secure_file_priv=''

40、MySQL 导出数据
    1、SELECT * FROM runoob_tbl INTO OUTFILE '/tmp/runoob.txt';
    2、mysqldump -u root -p RUNOOB runoob_tbl > dump.txt

41、MySQL 导入数据
    1、mysql -uroot -p123456 < runoob.sql
    2、mysql> source /home/abc/abc.sql
    3、mysqlimport -u root -p --local mytbl dump.txt

42、MySQL 运算符
    1、select 10 DIV 4;
    2、select 1+2


