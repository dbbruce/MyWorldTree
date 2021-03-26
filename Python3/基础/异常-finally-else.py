# coding:utf-8

# finally与else区别
# 1、finally无论是否发生异常都会执行；
# 2、else只有程序没有异常才会执行；
# finally格式
try:
    print('a')
except:
    print("error")
finally:
    print("stop")
# else格式
try:
    print('a')
except:
    print("error")
else:
    print("stop")