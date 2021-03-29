# coding: utf-8
# @Time : 2021/3/29 3:22 下午 
# @Author : DB.Bruce Dong

# 1、流对象
# 到目前为止，我们都知道 Python 有一个内置的函数叫做 open()。
# open()函数返回一个流对象(stream object)，它拥有 一些用来获取信息和操作字符流的方法和属性。

# 2、关闭文件首选 with
# 当 with 块结 束时，Python 自动调用 a_file.close()。
# 从技术上说，with语句创建了一个运行时环境(runtimecontext)。在这几个样例中，流对象的行为就像一个上下文管理器(context
# manager)。Python创建了a_file， 并且告诉它正进入一个运行时环境。当with块结束的时候，
# Python告诉流对象它正在退出这个运行时环境，然后流对象就会调用它的close()方法。


# 3、二进制的流对象
# 二进制的流对象没有 encoding 属性。你能明白其中的道理的，对吧?现在你读写的是字节，而不是字符串，
# 所以 Python 不需要做转换工作。从二进制文件里 读出的跟你所写入的是完全一样的，所以没有执行转换的必要。
# 字符
s1 = open('./闭包.py', 'r')
s1.encoding
# Out[20]: 'UTF-8'

# 字节
s1 = open('./闭包.py', 'rb')
s1.encoding
# 报错：AttributeError: '_io.BufferedReader' object has no attribute 'encoding'

# 4、io模块定义了StringIO 类，你可以使用它来把内存中的字 符串当作文件来处理。
# StringIO和BytesIO
# 很多时候，数据读写不一定是文件，也可以在内存中读写。StringIO就是在内存中读写str。
# StringIO操作的只能是str，如果要操作二进制数据，就需要使用BytesIO。
# getvalue() 方法用于获得写入后的str。
# StringIO和BytesIO是在内存中操作str和bytes的方法，使得和读写文件具有一致的接口。

# 要把str写入StringIO，我们需要先创建一个StringIO，然后，像文件一样写入即可：
from io import StringIO
f = StringIO()
f.write('hello')
f.write(' ')
f.write('world!')
print(f.getvalue())
# hello
# world!


# 要读取StringIO，可以用一个str初始化StringIO，然后，像读文件一样读取：
from io import StringIO
f = StringIO('Hello!\nHi!\nGoodbye!')
while True:
    s = f.readline()
    if s == '':
        break
    print(s.strip())
# Hello!
# Hi!
# Goodbye!


# BytesIO实现了在内存中读写bytes，我们创建一个BytesIO，然后写入一些bytes：
from io import BytesIO
f = BytesIO()
f.write('中文'.encode('utf-8'))
print(f.getvalue())
# b'\xe4\xb8\xad\xe6\x96\x87'
# 注意，写入的不是str，而是经过UTF-8编码的bytes。


# 和StringIO类似，可以用一个bytes初始化BytesIO，然后，像读文件一样读取：
from io import BytesIO
f = BytesIO(b'\xe4\xb8\xad\xe6\x96\x87')
f.read()
# b'\xe4\xb8\xad\xe6\x96\x87'
