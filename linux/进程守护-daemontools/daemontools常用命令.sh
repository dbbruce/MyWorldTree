# 1、启动
/etc/rc.local
csh -cf '/command/svscanboot &'

# 2、daemontools 软件包包含
#svscanboot 是一个普通的脚本, 用来运行svscan,把输出定向到readproctitle.
#svscan 检查服务目录,为每一个找到的脚本开始管理进程.
#supervise运行 svscan给它的运行脚本,监听脚本开始的进程,当进程死亡的时候,使之重新运行.
#svc 发送信号到在supervise下运行的进程.
#svok 检查目录中运行的 supervise .
#svstat 显示supervise监听到的进程的状态.
#fghack 防止进程把自己放到后台运行.
#pgrphack 在单独的进程组里开启一个进程.
#readproctitle 显示ps输出的log文件.
#multilog 是登陆程序.它从daemon获得输出,添加到log文档里.
#tai64n 是一个timestamp生成程序.
#tai64nlocal 改变 tai64n 输出文件到可读的格式.
#setuidgid 在指定的帐号下运行一个特定的程序.
#envuidgid 完成setuidgid程序的功能,但是设置环境变量$UID 和 $GID 帐号提供的UID和GID
#envdir 在目录里运行利用环境变量提供的程序.
#softlimit 对指定程序允许资源限制.
#setlock 锁住可执行程序的文件

# 3、svc 
svc opts services
opts是一系列的参数,services是指/service下的服务目录.opts参数如下:
-u : up, 如果services没有运行的话,启动它,如果services停止了,重启它.
-d : down, 如果services正在运行的话,给它发送一个TERM(terminate)信号,然后再发送一个CONT(continue)信号,在它停止后,不再启动它.
-o : once, 如果services没有运行,启动它,但是在它停止后不再启动了.就是只运行一次.
-p : pause, 给services发送一个停止信号.
-c : continue, 给services发送一个CONT信号.
-h : hang up, 给services发送一个HUP信号.
-a : alarm, 给services发送一个ALRM信号.
-i : interrupt, 给services发送一个INT信号.
-t : Terminate, 给services发送一个TERM信号.
-k : kill, 给services发送一个KILL信号.
-x : exit, supervise在services停止后会立刻退出, 但是值得注意的是,如果你在一个稳定的系统中使用了这个选项,你已经开始犯错了:supervise被设计成为永远运行的.
关掉一个服务进程通常使用-dk参数,此时supervise进程并没有关闭,所以依然可以将这个服务进程重启.即使,supervice进程挂掉了,svscan依然会重启supervise,supervise会重新运行服务进程的run脚本.