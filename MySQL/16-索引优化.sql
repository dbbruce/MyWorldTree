1、索引失效（应该避免）
    1、全值匹配我最爱，
        比如 where name='dbbruce';

    2、最佳左前缀法则，如果是复合索引（ table1(c1,c2,c3)）,
        要遵守最佳左前缀法则，
        1、第一个索引必须是最左侧索引（c1）；
        2、不能跳过中间索引（c2）;

    3、不在索引列上做任何操作，比如计算，函数，类型转换，会导致索引失效;
        比如，索引列name失效, left(name, 4)='dong';

    4、存储引擎不能使用范围条件右侧的列；
        比如 where c1=1 and c2>2 and c3=4； c1,c2索引有效,c3 索引失效；

    5、尽量使用覆盖索引（索引列与查询列一直），只查询索引的列，不使用select *
        比如：索引 c1,c2,c3 ;select c1,c2,c3 这样非常好；

    6、mysql在使用不等于（!=， <>）,无法使用索引，会导致扫描全表

    7、is null , is not null 无法使用索引

    8、like 用通配符开头（like "%abc"）索引失效，扫描全表
        1、select a,b from table1 where a like "%abc"   索引失效
        2、select a,b from table1 where a like "%abc%"   索引失效
        3、select a,b from table1 where a like "abc%"   索引可以，like 通配符要放右边
        4、两边%号，使用覆盖索引解决，
            create index idx_c on table1(a,b);
            select a,b from table1 where a like "%abc%" ;索引生效；
    9、字符串不加单引号，索引失效
        比如：name varchar,
        select * from table1 where name=22222; mysql将name字段进行了类型转换，索引失效；
        select * from table1 where name='22222'; 字符串必须有单引号；索引生效

    10、少用or，使用or连接时索引会失效

2、order by 排查
    1、index (c1,c2,c3,c4)
    2、select * from t1 where c1='1' order by
    3、 c3,c2; c3,c2索引错序，但是这条SQL性能很好；
    4、 注意，当有一条数据时，order by就无所谓了，一条数据，性能必须好；


3、索引优化，一般性建议
    1、对于单键索引，一般选择针对当前query过滤最好的索引；
    2、对于组合索引，当前query中过滤性最好的字段在索引字段的顺序中，位置越靠前越好；
    3、在选择组合索引时，尽量选择可以包含当前where子句中更多的字段；
    4、通过分析和调整query的写法来达到选择合适索引的目的；














