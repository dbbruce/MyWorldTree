1、explain
explain模拟优化器执行SQL语句，分析SQL语句或者表结构的性能瓶颈；

2、使用方法，explain+SQL
explain selct * form tbl;

3、能干什么
    1、表的读取顺序；
    2、数据读取操作的操作符；
    3、哪些索引可以使用；
    4、哪些索引实际使用；
    5、表之间的引用；
    6、每张表有多少行被优化器查询；

4、explain select hostname,server_ip from k_vir_vmserver  where vmservergroup_id in (select id from k_vir_vmservergroup where name like '%boss%');
+----+-------------+---------------------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
| id | select_type | table               | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                              |
+----+-------------+---------------------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
|  1 | SIMPLE      | k_vir_vmservergroup | NULL       | ALL  | PRIMARY       | NULL | NULL    | NULL |   10 |    11.11 | Using where                                        |
|  1 | SIMPLE      | k_vir_vmserver      | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 1329 |    10.00 | Using where; Using join buffer (Block Nested Loop) |
+----+-------------+---------------------+------------+------+---------------+------+---------+------+------+----------+----------------------------------------------------+
EXPLAIN列的解释
id：查询的序列号，表示select或子语句执行的顺序，3种情况
    id值相同：顺序执行，从上向下执行；
    id值不同：id值越大，越先执行；
    id相同又不同：先走id大值；id值相同的从上向下执行； （有时table字段里的内容为"derived 2", 这里derived衍生表（查询新生成的表）， 这里的2指id值）

select_type:查询类型，主要区别普通查询，子查询，联合查询
    6种常见的值
    simple 简单查询，不包含子查询和union
    primary 查询中包含复杂的子查询，最外层标记为primary
    subquery 在select或者where包含子查询
    derived  from列表中包含子查询，子查询结果放在临时表中
    unique  若第二个select在union后，被标记为union；
    unique result 从union表获取结果的select

table:2种情况
    1、表名
    2、derived衍生表（查询新生成的表

type:
    显示查询使用了何种类型。一般到达range和ref就可以了
    从最好到最差的连接类型为: system>const>eq_ref>ref>range>index>all
    system :表中只有一条记录，类似系统表，这是const类型的特例；
    const ：表示一次索引就能查到，比如primary和unique，因为只匹配一条数据； 例如where id=12;
    eq_ref : 唯一索引扫描，对于每个索引，只有一条记录与只匹配；常见与主键和唯一索引， where t1.id= t2.id;
    ref : 非唯一索引，返回匹配某个值得所有行；
    range ： 只检索给定范围的行，使用一个索引来选择行，一般关键字是between,in,<,>,
    index : index与all的区别是遍历索引树；
    all : all扫描全表，而且数据比较大（百万），一定要优化；

possible_keys
    显示可能应用在这张表中的索引。如果为空，没有可能的索引。注意，单可能不是使用

key
    实际使用的索引。如果为NULL，则没有使用索引。
    很少的情况下，MYSQL会选择优化不足的索引。这种情况下，可以在SELECT语句 中使用USE INDEX（indexname）来强制使用一个索引
    或者用IGNORE INDEX（indexname）来强制MYSQL忽略索引

key_len
    使用的索引的长度。在不损失精确性的情况下，长度越短越好
    显示的值为索引字段的最多可能长度，并非实际使用长度，即key_len是根据表定义计算来的。

ref
    显示索引的哪一列被使用了，如果可能的话，是一个常数（const），db1.t1.c1字段；

rows
    根据表信息和索引选用情况，大致估算出找出所需记录，所需读取的行数；rows越小越好

Extra
    包含不适合在其他列显示的信息，但是十分重要；
    Using filesort: 当Query中包含 order by 操作，而且无法利用索引完成的排序操作称为"文件排序"；（必须优化，排序没有使用索引，很严重）
    Using temporary：表示MySQL需要使用临时表来存储结果集，常见于排序和分组查询，常见 group by 、 order by；（必须优化，group by 最好用索引，很很严重）
    Using index: 不用读取表中所有信息，仅通过索引就可以获取所需数据，（非常好）
                 同时出现 Using where,索引用来执行，索引键值的查找
    Using where： 表明使用where过滤数据
    Using join buffer： 使用连接缓存
    impossible where：  where子句的值是false 比如 where a=1 and a=2,A只有一个值，这个子句肯定返回false；


覆盖索引（索引覆盖）：创建一个复合索引，顺序是t1,t2,t3字段;查询是 select t1,t2,t3 from table1; 查询是字段的顺序和字段与索引一样，就是覆盖索引；
       覆盖索引不查表，直接从索引取数据；--非常高效；



