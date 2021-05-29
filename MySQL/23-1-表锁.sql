1、表级锁定分为表共享读锁（共享锁）与表独占写锁（排他锁）
    读锁 （共享锁（Shared Lock）/ S锁）：针对一份数据，多个读操作可以同时进行，而不会互相影响；
        加了S锁后，该事务只能对数据进行读取而不能修改，并且其它事务只能加S锁，不能加X锁
    写锁（排它锁（Exclusive Lock）/ X锁）：当前操作没有完成，会影戏其他读和写；
        事务对数据加上X锁时，只允许此事务读取和修改此数据，并且其它事务不能对该数据加任何锁；

2、查看锁信息, In_use为1时，表有锁
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

3、添加表锁
    lock table p_sort read, p write;  同时给2张表添加锁，一个读，一个写

4、释放表锁
    unlock tables;

5、读锁， session1添加读锁
    session1（加锁session）  ||    session2
    可以查询                 ||    可以查询
    不能查询其他未锁的表       ||    可以查询或者更新其他未锁的表
    插入或者更新，提示错误     ||    插入或者更新会一直等待获得锁，也就是阻塞了
    释放锁                   ||    插入或更新完成

6、写锁， session1添加写锁
    session1（加锁session）  ||    session2
    可以查询，更新，插入       ||   任何操作都阻塞，等待锁；

7、总结，读锁会阻塞写，但是不会堵塞读；而写锁则会把读和写都阻塞；

8、如何分析表锁定
    show status like 'table%';
    +----------------------------+-------+
    | Variable_name              | Value |
    +----------------------------+-------+
    | Table_locks_immediate      | 70    |
    | Table_locks_waited         | 0     |

    Table_locks_immediate : 产生表级锁定的次数，标识可以立即获取所得查询次数，每立即获取锁值加1；
    Table_locks_waited : 出现表级锁定争用而发生等待的次数（不能立即获取锁的次数，没等待一次锁值加1），此值高则说明存在着
    较严重的表级锁争用情况；

9、MyISAM的读取锁调度是写优先，也就是不适合做写为主表的引擎。因为写锁后，其他线程不能做任何操作，大量的更新会使查询很难得到锁，
    从而造成永远阻塞；

