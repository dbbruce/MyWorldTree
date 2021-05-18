视图是一个虚拟表，是sql的查询结果，其内容由查询定义。同真实的表一样，视图包含一系列带有名称的列和行数据，在使用视图时动态生成。

1、创建视图
create view  视图名  as  select 字段名 from 表名;
CREATE VIEW view_students_info AS SELECT * FROM tb_students_info;

2、修改视图
alter view 视图名 as select 语句;
ALTER VIEW view_students_info AS SELECT id,name,age FROM tb_students_info;


3、删除视图
drop view 视图名;
DROP VIEW IF EXISTS v_students_info;

4、重命名视图
Rename table 视图名 to 新视图名;


