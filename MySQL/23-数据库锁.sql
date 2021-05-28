1、锁是计算机协调多个进程或线程并发访问某一资源的机制；

2、MyISAM和InnoDB存储引擎使用的锁：
    MyISAM采用表级锁(table-level locking)。
    InnoDB支持行级锁(row-level locking)和表级锁，默认为行级锁

3、数据库粒度分类：表锁和行锁

4、三锁
    1、表锁（偏读）：
        表级锁是MySQL中锁定粒度最大的一种锁，表示对当前操作的整张表加锁，它实现简单，资源消耗较少，
        被大部分MySQL引擎支持。最常使用的MYISAM与INNODB都支持表级锁定。表级锁定分为表共享读锁（共享锁）与表独占写锁（排他锁）。
        特点
            开销小，加锁快；
            不会出现死锁；
            锁定粒度大，发生锁冲突的概率最高，并发度最低。

    2、行锁（偏写）：
        行级锁是Mysql中锁定粒度最细的一种锁，表示只针对当前操作的行进行加锁。
        行级锁能大大减少数据库操作的冲突。其加锁粒度最小，但加锁的开销也最大。行级锁分为 共享锁 和 排他锁。
        特点
            开销大，加锁慢；
            会出现死锁；
            锁定粒度最小，发生锁冲突的概率最低，并发度也最高

    3、页锁：
        页级锁是MySQL中锁定粒度介于行级锁和表级锁中间的一种锁。
        表级锁速度快，但冲突多，行级冲突少，但速度慢。所以取了折衷的页级，一次锁定相邻的一组记录。
        特点
            开销和加锁时间界于表锁和行锁之间；
            会出现死锁；
            锁定粒度界于表锁和行锁之间，并发度一般

5、表级锁定分为表共享读锁（共享锁）与表独占写锁（排他锁）
    读锁 （共享锁（Shared Lock）/ S锁）：针对一份数据，多个读操作可以同时进行，而不会互相影响；
        加了S锁后，该事务只能对数据进行读取而不能修改，并且其它事务只能加S锁，不能加X锁
    写锁（排它锁（Exclusive Lock）/ X锁）：当前操作没有完成，会影戏其他读和写；
        事务对数据加上X锁时，只允许此事务读取和修改此数据，并且其它事务不能对该数据加任何锁；

6、查看锁信息, In_use为1时，表有锁
    show open tables;
    +--------------------+----------------------------------------------------+--------+-------------+
    | Database           | Table                                              | In_use | Name_locked |
    +--------------------+----------------------------------------------------+--------+-------------+
    | performance_schema | events_waits_history                               |      0 |           0 |
    | performance_schema | events_waits_summary_global_by_event_name          |      0 |           0 |
    | test_db1           | testalter_tbl                                      |      0 |           0 |
    | performance_schema | events_waits_history_long                          |      0 |           0 |
    | performance_schema | events_statements_summary_by_digest                |      0 |           0 |
    | performance_schema | mutex_instances                                    |      0 |           0 |
    | performance_schema | events_waits_summary_by_instance                   |      0 |           0 |
    | performance_schema | events_stages_history                              |      0 |           0 |
    | my_db              | auth_user_user_permissions                         |      0 |           0 |
    | mysql              | help_keyword                                       |      0 |           0 |
    | mysql              | user                                               |      0 |           0 |
    | test_db1           | tb_dept_bigdata                                    |      0 |           0 |
    | test_db1           | p_sort                                             |      1 |           0 |

7、添加表锁
    lock table p_sort read, p write;  同时给2张表添加锁，一个读，一个写

9、释放表锁
    unlock tables;

8、读锁， session1添加读锁
    session1（加锁session）  ||    session2
    可以查询                 ||    可以查询
    不能查询其他未锁的表       ||    可以查询或者更新其他未锁的表
    插入或者更新，提示错误     ||    插入或者更新会一直等待获得锁，也就是阻塞了
    释放锁                   ||    插入或更新完成

9、写锁， session1添加写锁
    session1（加锁session）  ||    session2
    可以查询，更新，插入       ||   任何操作都阻塞，等待锁；

10、总结，读锁会阻塞写，但是不会堵塞读；而写锁则会把读和写都阻塞；

11、如何分析表锁定
    show status like 'table%';
    +----------------------------+-------+
    | Variable_name              | Value |
    +----------------------------+-------+
    | Table_locks_immediate      | 70    |
    | Table_locks_waited         | 0     |

    Table_locks_immediate : 产生表级锁定的次数，标识可以立即获取所得查询次数，每立即获取锁值加1；
    Table_locks_waited : 出现表级锁定争用而发生等待的次数（不能立即获取锁的次数，没等待一次锁值加1），此值高则说明存在着
    较严重的表级锁争用情况；

12、MyISAM的读取锁调度是写优先，也就是不适合做写为主表的引擎。因为写锁后，其他线程不能做任何操作，大量的更新会使查询很难得到锁，
    从而造成永远阻塞；

13、行锁理论
    并发事务处理带来的问题：
    1、更新丢失 （lost update）-多个事务操作同一行数据，都是基于初始值操作，每个事务不知道其他事务存在，发生丢失更新的问题
    2、脏读 (dirty reads)-事务A读取了事务B修改未提交的数据，还基于数据做了操作，B事务回滚，A读取的数据无效，不符合一致性
    3、不可重复读 (Non_repeatable reads)-事务A读取了某个数据后，再次读取以前读过的数据，发现数据变动，或删除；
    4、幻读 (phantom reads)-事务A读取到了事务B提交的新增数据，不符合隔离性；

    脏读和幻读
    脏读：读取B事务里面修改的数据；
    幻读：读取B事务里面新增的数据；

14、查看当前数据库事务隔离级别：
    show variables like 'tx_isolation';
    +---------------+-----------------+
    | Variable_name | Value           |
    +---------------+-----------------+
    | tx_isolation  | REPEATABLE-READ |
    +---------------+-----------------+

    隔离级别----------------------读数据一致性---------------------脏读------不可重复读------幻读
    未提交读 （read uncommitted）- 最低级别，只能保证不读取损坏数据 -- 是 ------   是   ------- 是
    已提交读 （read committed）-    语句级 ------------------------ 否 -------  是   ------- 是
    可重复读 （repeatable read）-   事务级  ----------------------- 否   ------  否   ------- 是
    可序列化 （seralizable）-       最高级，事务  ------------------ 否   ------ 否   -------- 否

15、

16、

17、
