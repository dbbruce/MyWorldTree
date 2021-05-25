0、explain type出现all，extra出现 filesort一定需要优化

1、单表
 原SQL：select id,author from table1 where c1=1 and c2>1 order by v1 desc limit 1;
 1、分析sql，
    explain select id,author from table1 where c1=1 and c2>1 order by v1 desc limit 1；
 2、查看索引
    show index from table1;
 3、使用where后的条件创建索引，c1,c2,v1，顺序创建索引
    create index idx_ccv on table1(c1,c2,v1);
 4、分析SQL，SQL中有范围操作符，（>,<,in）,范围操作符后的索引失效；
    explain select id,author from table1 where c1=1 and c2>1 order by v1 desc limit 1；
 5、删除索引
    drop index idx_ccv on table1;
 6、不对范围搜索字段创建索引，c2>1不创建索引
    create index idx_ccv on table1(c1,v1);

2、双表
    原SQL：select * from class left join book on class.card=book.card;
    1、分析
        explain select * from class left join book on class.card=book.card;
    2、left join建在右表，book表上；

3、多表
    原SQL：select * from class left join book on class.card=book.card left join phone on book.card=phone.card;
    1、右侧表创建索引，book.card创建索引，phone.card创建索引；
4、join优化总结
    1、小数据表在前；
    2、优先优化内层循环；
    3、被驱动的表创建索引，left join 右表创建索引；
    4、inner join 增加mysql缓存；

