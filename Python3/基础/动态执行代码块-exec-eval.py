# coding: utf-8
# @Time : 2021/4/6 9:58 下午 
# @Author : DB.Bruce Dong

# exec() 无返回值，可以动态执行复杂的代码块
# eval() 有返回值，只能执行简单的表达式代码块
# 在这里先简单的对exec()进行介绍，eval()后期再进行更新
# exec()执行样例：

# 动态方法-1
if __name__ == '__main__':
    a = """
def test():
   for i in range(5):
       print("iter time: %d" % i)
   return 1111
"""
    exec(a)
    b = test()
    print(b)
# 执行结果：
# iter time: 0
# iter time: 1
# iter time: 2
# iter time: 3
# iter time: 4
# 1111

# 动态方法-2

if __name__ == '__main__':
    code = '''
def code_index(radius):
   return radius * 2
'''
    # code_index代表的是代码块里的函数名称, data代表代码块执行要返回的值
    constant = globals().copy()   # globals() 函数会以字典类型返回当前位置的全部全局变量。
    exec(code, constant)
    data = constant["code_index"](1)
    print(data)


# 动态方法-3
expr = """
def f1(x, y):
    sum = x + y
    print(sum)
f1(a,b)
"""

exec(expr, {'a': 1, 'b': 2})
exec(expr, {'a': 3, 'b': 4})

# def func():
#     exec(expr, {'a': 1, 'b': 2})
#     exec(expr, {'a': 3, 'b': 4})
#
#
# func()