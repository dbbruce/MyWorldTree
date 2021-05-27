#1.创建tb_dept_bigdata（部门表）。
    create table tb_dept_bigdata(
    id int unsigned primary key auto_increment,
    deptno mediumint unsigned not null default 0,
    dname varchar(20) not null default '',
    loc varchar(13) not null default ''
    )engine=innodb default charset=utf8;

#2.创建tb_emp_bigdata（员工表）
    create table tb_emp_bigdata(
    id int unsigned primary key auto_increment,
    empno mediumint unsigned not null default 0,/*编号*/
    empname varchar(20) not null default '',/*名字*/
    job varchar(9) not null default '',/*工作*/
    mgr mediumint unsigned not null default 0,/*上级编号*/
    hiredate date not null,/*入职时间*/
    sal decimal(7,2) not null,/*薪水*/
    comm decimal(7,2) not null,/*红利*/
    deptno mediumint unsigned not null default 0 /*部门编号*/
    )engine=innodb default charset=utf8;

#3.开启log_bin_trust_function_creators参数。
    由于在创建函数时，可能会报：This function has none of DETERMINISTIC.....因此我们需开启函数创建的信任功能。
    show variables like '%log_bin_trust_function_creators%';
    +---------------------------------+-------+
    | Variable_name                   | Value |
    +---------------------------------+-------+
    | log_bin_trust_function_creators | OFF   |
    +---------------------------------+-------+
    1 row in set (0.01 sec)
    开启： set global log_bin_trust_function_creators=1;
    关闭： set global log_bin_trust_function_creators=0;

#1.创建随机生成字符串的函数。
    delimiter $$
    drop function if exists rand_string;
    create function rand_string(n int) returns varchar(255)
    begin
    declare chars_str varchar(52) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    declare return_str varchar(255) default '';
    declare i int default 0;
    while i<n do
    set return_str=concat(return_str,substring(chars_str,floor(1+rand()*52),1));
    set i=i+1;
    end while;
    return return_str;
    end $$

#2.创建随机生成编号的函数
    delimiter $$
    drop function if exists rand_num;
    create function rand_num() returns int(5)
    begin
    declare i int default 0;
    set i=floor(100+rand()*100);
    return i;
    end $$

#3.创建存储过程用于批量插入数据
    delimiter $$
    drop procedure if exists insert_dept;
    create procedure insert_dept(in start int(10),in max_num int(10))
    begin
    declare i int default 0;
    set autocommit=0;
    repeat
    set i=i+1;
    insert into tb_dept_bigdata (deptno,dname,loc) values(rand_num(),rand_string(10),rand_string(8));
    until i=max_num
    end repeat;
    commit;
    end $$

#4.创建往tb_emp_bigdata表中插入数据的存储过程
    delimiter $$
    drop procedure if exists insert_emp;
    create procedure insert_emp(in start int(10),in max_num int(10))
    begin
    declare i int default 0;
    set autocommit=0;
    repeat
    set i=i+1;
    insert into tb_emp_bigdata (empno,empname,job,mgr,hiredate,sal,comm,deptno) values((start+i),rand_string(6),'developer',0001,curdate(),2000,400,rand_num());
    until i=max_num
    end repeat;
    commit;
    end $$

#5.查看function状态
    show function status;

#6.查看procedure状态
    show procedure status;

#7.调用存储过程
    call insert_dept(100, 100);
    call insert_emp(100, 300);

#1.删除函数
    drop function rand_num;
    drop function rand_string;

#2.删除存储过程
    drop procedure insert_dept;
    drop procedure insert_emp;




