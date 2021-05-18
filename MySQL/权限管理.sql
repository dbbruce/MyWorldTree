1、创建账号
本地账号，服务上可以登录
create user 'user1'@'localhost' identified by '123456';
远程账号
create user 'user1'@'192.168.1.1' identified by '123456';
create user 'user1'@'192.168.1.%' identified by '123456';  # 192.168.1网段访问
create user 'user1'@'%' identified by '123456';  # 全部能访问

2、授权
权限控制表；
user表         ---- 控制所有库，所有表； *.*
db表           ---- 某一个库； db1.*
table_priv表   ---- 某个表； db1.table1
column_priv表  ---- 某个字段；  table1.id

授权
grant all/select/delete/insert/update  on *.* to 'user1'@'localhost';  # 注意 grant语句不能给账号赋予"授权权限-grant"
回收权限
revoke all/select/delete/insert/update from  *.* to 'user1'@'localhost';


grant all on db1.* to 'user1'@'localhost';
grant all on db1.t1 to 'user1'@'localhost';
grant select(id,name),udpate(age) on db1.t1 to 'user1'@'localhost';  # 只能查看t1表id和name,只能更新t1表age字段；
