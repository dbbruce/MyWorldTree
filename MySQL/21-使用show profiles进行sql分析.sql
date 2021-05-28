1、profile
    用来分析当前会话中sql语句执行的资源消耗情况。
    默认情况关闭，保存最近15运行情况

2、分析步骤：
    1、查看mysql是否支持，mysql5.0.3版本以后才开放；select version();
         show variables like '%profiling%';
        +------------------------+-------+
        | Variable_name          | Value |
        +------------------------+-------+
        | have_profiling         | YES   |
        | profiling              | ON    |
        | profiling_history_size | 15    |
        +------------------------+-------+
        3 rows in set (0.00 sec)

    2、开启功能，默认是关闭，
        set profiling=1;

    3、运行SQL

    4、查看结果，show profiles;
        show profiles;
        +----------+------------+-----------------------------------+
        | Query_ID | Duration   | Query                             |
        +----------+------------+-----------------------------------+
        |        1 | 0.00103600 | show variables like '%profile%'   |
        |        2 | 0.00078500 | show variables like '%profiling%' |
        |        3 | 1.00538800 | select sleep(1)                   |
        |        4 | 0.00032500 | show variables like '%profiling%' |
        |        5 | 0.00137200 | show profiling all                |
        |        6 | 0.00013100 | show profiling                    |
        |        7 | 0.00007300 | show profiles all                 |
        |        8 | 0.00003800 | show profil all                   |
        |        9 | 0.00182700 | select version()                  |
        |       10 | 0.00351500 | set profiling=1                   |
        |       11 | 0.00122100 | show variables like '%profiling%' |

    5、诊断SQL，show profile cpu，block，io for query上一步前面的问题SQL数字号码；
        参数：
             | ALL                --显示所有的开销信息
             | BLOCK IO          --显示块IO相关开销
             | CONTEXT SWITCHES  --上下文切换相关开销
             | CPU                --显示CPU相关开销信息
             | IPC                --显示发送和接收相关开销信息
             | MEMORY            --显示内存相关开销信息
             | PAGE FAULTS        --显示页面错误相关开销信息
             | SOURCE            --显示和Source_function，Source_file，Source_line相关的开销信息
             | SWAPS              --显示交换次数相关开销的信息
            用法： show profile all for query 2;

        例子：
            show profile cpu, block io for query 2;  注意这里的2指上面的Query_ID
            +----------------------+----------+----------+------------+--------------+---------------+
            | Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
            +----------------------+----------+----------+------------+--------------+---------------+
            | starting             | 0.000045 | 0.000038 |   0.000007 |            0 |             0 |开始
            | checking permissions | 0.000029 | 0.000009 |   0.000020 |            0 |             0 |检查权限
            | Opening tables       | 0.000048 | 0.000045 |   0.000003 |            0 |             0 |打开表
            | init                 | 0.000012 | 0.000010 |   0.000002 |            0 |             0 |初始
            | System lock          | 0.000005 | 0.000004 |   0.000001 |            0 |             0 |系统锁
            | optimizing           | 0.000006 | 0.000004 |   0.000002 |            0 |             0 |优化
            | statistics           | 0.000012 | 0.000010 |   0.000001 |            0 |             0 |统计
            | preparing            | 0.000010 | 0.000010 |   0.000001 |            0 |             0 |准备
            | executing            | 0.000519 | 0.000479 |   0.000040 |            0 |             0 |执行
            | Sending data         | 0.000023 | 0.000021 |   0.000002 |            0 |             0 |发送数据
            | Sorting result ：排序
            | end                  | 0.000005 | 0.000003 |   0.000002 |            0 |             0 |结束
            | query end            | 0.000006 | 0.000004 |   0.000001 |            0 |             0 |查询 结束
            | closing tables       | 0.000004 | 0.000003 |   0.000001 |            0 |             0 |关闭表
            | removing tmp table   | 0.000013 | 0.000010 |   0.000004 |            0 |             0 |去除TMP 表
            | closing tables       | 0.000006 | 0.000004 |   0.000001 |            0 |             0 |关闭表
            | freeing items        | 0.000023 | 0.000009 |   0.000014 |            0 |             0 |释放物品
            | cleaning up          | 0.000019 | 0.000018 |   0.000002 |            0 |             0 |清理
            +----------------------+----------+----------+------------+--------------+---------------+

            4个重要指标：(出现一个都有问题)
                1、converting HEAP to MyISAM 查询结果太大，内存不够用，往磁盘上搬
                2、creating tmp table 创建临时表（group by会创建临时表） 1、拷贝数据到临时表  2、用完再删除
                3、coping to tmp table on disk 把内存中临时表复制到磁盘，危险；
                4、locked
