1、SQL 优化步骤
    1、观察，生成环境，mysql数据库跑一天；
    2、开启慢查询日志，设置阈值，比如超过5秒钟的就是慢sql，并抓出来；
    3、explain + 慢SQL分析
    4、show profile
    5、DBA进行数据库服务器参数调优

2、永远小表驱动大表
    select * from A where id in (select * form B);

    1、 当B数据小于A时，in优先
    select * from A where id in (select * form B);
    2、当B数据大于A时，exists优先
    select * from A where exists (select 1 from B where B.id=A.id);

3、in的替换
    exists语法： exists（子查询）只返回True、False，exists可以替换in
    select * from A where id in (select * form B);
    select * from A where exists (select 1 from B where B.id=A.id);



