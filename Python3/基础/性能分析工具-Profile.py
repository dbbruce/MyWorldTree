# coding: utf-8
# @Time : 2021/4/7 2:19 下午 
# @Author : DB.Bruce Dong

# 使用Profile
import profile
def a():
    sum = 0
    for i in range(1, 10001):
        sum += i
    return sum
def b():
    sum = 0
    for i in range(1, 100):
        sum += a()
    return sum
if __name__ == "__main__":
   profile.run("b()")

# 104 function calls in 0.062 seconds
# Ordered by: standard name
# ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#     1    0.000    0.000    0.060    0.060 :0(exec)
#     1    0.001    0.001    0.001    0.001 :0(setprofile)
#     1    0.000    0.000    0.060    0.060 <string>:1(<module>)
#     1    0.001    0.001    0.060    0.060 chardet's setup.py:13(b)
#    99    0.060    0.001    0.060    0.001 chardet's setup.py:7(a)
#     1    0.000    0.000    0.062    0.062 profile:0(b())
#     0    0.000             0.000          profile:0(profiler)

# 其中输出每列的具体解释如下：
# ● ncalls：表示函数调用的次数；
# ● tottime：表示指定函数的总的运行时间，除掉函数中调用子函数的运行时间；
# ● percall：（第一个percall）等于tottime / ncalls；
# ● cumtime：表示该函数及其所有子函数的调用运行的时间，即函数开始调用到返回的时间；
# ● percall：（第二个percall）即函数运行一次的平均时间，等于cumtime / ncalls；
# ● filename: lineno(function)：每个函数调用的具体信息；
# 如果需要将输出以日志的形式保存，只需要在调用的时候加入另外一个参数。如profile.run(“profileTest()”, ”testprof”)。

# 命令行
# 如果我们不想在程序中调用profile库使用，可以在命令行使用命令
# 运行命令查看性能分析结果
# python -m cProfile test.py

# 将性能分析结果保存到result文件
# python -m cProfile -o result test.py



