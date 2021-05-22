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






table==显示这一行的数据是关于哪张表的
type==这是重要的列，显示连接使用了何种类型。从最好到最差的连接类型为const、eq_reg、ref、range、indexhe和ALL
possible_keys==显示可能应用在这张表中的索引。如果为空，没有可能的索引。可以为相关的域从WHERE语句中选择一个合适的语句
key==实际使用的索引。如果为NULL，则没有使用索引。很少的情况下，MYSQL会选择优化不足的索引。这种情况下，可以在SELECT语句 中使用USE INDEX（indexname）来强制使用一个索引或者用IGNORE INDEX（indexname）来强制MYSQL忽略索引
key_len==使用的索引的长度。在不损失精确性的情况下，长度越短越好
ref==显示索引的哪一列被使用了，如果可能的话，是一个常数
rows==MYSQL认为必须检查的用来返回请求数据的行数
Extra==关于MYSQL如何解析查询的额外信息。将在表4.3中讨论，但这里可以看到的坏的例子是Using temporary和Using filesort，意思MYSQL根本不能使用索引，结果是检索会很慢

