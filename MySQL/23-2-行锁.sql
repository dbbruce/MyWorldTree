1、行锁理论
    并发事务处理带来的问题：
    1、更新丢失 （lost update）-多个事务操作同一行数据，都是基于初始值操作，每个事务不知道其他事务存在，发生丢失更新的问题
    2、脏读 (dirty reads)-事务A读取了事务B修改未提交的数据，还基于数据做了操作，B事务回滚，A读取的数据无效，不符合一致性
    3、不可重复读 (Non_repeatable reads)-事务A读取了某个数据后，再次读取以前读过的数据，发现数据变动，或删除；
    4、幻读 (phantom reads)-事务A读取到了事务B提交的新增数据，不符合隔离性；

    脏读和幻读
    脏读：读取B事务里面修改的数据；
    幻读：读取B事务里面新增的数据；

2、查看当前数据库事务隔离级别：
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

3、mysql 默认分号';'后自动提交，关闭自动提交；
    set autocommit=0;

4、提交
    commit；

5、行锁
    例如：
    session-1 ==============================session-2comment
    set autocommit=0; =======================set autocommit=0;
    update,不commit ========================= update阻塞，等待
    commit          =======================   完成，update，解除阻塞

6、行锁变表锁
    注意：字符字段做索引，使用是字符一定要加单引号；
    错误的：update t1 set a='a' where  b = b;  会导致行锁变表锁；
    正确的：update t1 set a='a' where b = 'b';

7、间隙锁的危害（范围都锁，不可操作）
    当我们用范围条件而不是相当条件检索数据，并请求共享或排他锁时，innodb会给符合条件的已有数据记录的索引项加锁；
    对于键值在条件范围内胆不存在的记录，叫做间隙（GAP）；
    innodb也会对这个间隙加锁，叫做间隙锁（next-key锁）
    例如：
    session1                                 ======================= session2
    update t1 set a='a' where c >1 and c <6; ======================= insert into t1(c) values(5)  ,阻塞,插入在update的范围；
    commit；                                 ======================= 解除阻塞，完成；

8、如何锁定一行
    begin；
    select * from t1 where a=8 for update； # 其他session 操作a=8阻塞； 锁定一行；
    XXXXX
    commit； # 其他session可以操作a=8;

9、行锁总结：
    innodb由于实现了行锁，锁定机制的实现方面所带来的性能损耗可能比表级会更高一些，但是在整体并发处理能力要远远由于优于MyISAM表级锁定。
    当系统并发较高时候，innodb整体性能和MyISAM比会有明显的优势；

    innodb也有脆弱的一面，当使用不当时，行锁变表锁；


10、分析行锁
    show status like 'innodb_row_lock%';
    +-------------------------------+-------+
    | Variable_name                 | Value |
    +-------------------------------+-------+
    | Innodb_row_lock_current_waits | 0     |
    | Innodb_row_lock_time          | 0     |
    | Innodb_row_lock_time_avg      | 0     |
    | Innodb_row_lock_time_max      | 0     |
    | Innodb_row_lock_waits         | 0     |

    Innodb_row_lock_current_waits ：当前正在等待锁定的数量； 0 当前无锁；
    Innodb_row_lock_time          ：从系统启动到现在锁定总时间长度；      # 这个是重要指标
    Innodb_row_lock_time_avg      ：每次等待所花平均时间；               # 这个是重要指标
    Innodb_row_lock_time_max      ：从系统启动到等待最长的一次所花时间；
    Innodb_row_lock_waits         ：系统启动后到现在总共等待的次数；这高就需查看了，show profile      # 这个是重要指标

11、行锁优化建议
    尽可能让所有数据检索通过索引完成，编码无索引行锁升级表锁；字符类型一定待单引号；
    合理设计索引，缩小锁范围
    尽可能减少检索条件，避免间隙锁；
    建立控制事务大小，减少锁定资源量和时间长度
    尽可能低级别事务隔离；

12、页锁
    开销和加锁界于表锁和行锁之间；会出现死锁；锁定颗粒度界于表锁和行锁之间，并发度高；
