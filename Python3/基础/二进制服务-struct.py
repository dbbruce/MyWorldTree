# coding: utf-8
# @Time : 2021/3/31 9:51 下午 
# @Author : DB.Bruce Dong

# Python正是使用struct模块执行Python值和C结构体之间的转换，从而形成Python字节对象。
# 它使用格式字符串作为底层C结构体的紧凑描述，进而根据这个格式字符串转换成Python值

# struct模块中最主要的三个函数式pack()、unpack()、calcsize()。
# pack(fmt, v1, v2, ...) - ----- 根据所给的fmt描述的格式将值v1，v2，...转换为一个字符串。
# unpack(fmt, bytes) - ----- 根据所给的fmt描述的格式将bytes反向解析出来，返回一个元组。
# calcsize(fmt) - ----- 根据所给的fmt描述的格式返回该结构的大小。
# 它们使用指定被打包/解包数据类型的 格式字符 进行构建。 此外，还有一些特殊字符用来控制 字节顺序，大小和对齐方式。


# 对齐方式
# 为了同c中的结构体交换数据，还要考虑c或c++编译器使用了字节对齐，通常是以4个字节为单位的32位系统，
# 故而struct根据本地机器字节顺序转换.可以用格式中的第一个字符来改变对齐方式.
# 定义如下格式字符串是用来在打包和解包数据时指定预期布局的机制。
# 字符|字节顺序|大小|对齐方式|
# @|按原字节|按原字节|按原字节|
# =|按原字节|标准|无|
# <|小端|标准|无|
# >|大端|标准|无|
# !|网络（=大端）|标准|无|

# 格式符
# struct模块来解决bytes和其他二进制数据类型的转换
# 格式符---------C语言类型---------Python类型---------Standard size
# x	---------pad byte(填充字节)	---------no value---------	 
# c	---------char	---------string of length 1	---------1
# b	---------signed char	---------integer	---------1
# B	---------unsigned char	---------integer	---------1
# ?	---------_Bool	---------bool	---------1
# h	---------short	---------integer	---------2
# H	---------unsigned ---------short	---------integer	---------2
# i	---------int	---------integer	---------4
# I(大写的i)	---------unsigned int	---------integer	---------4
# l(小写的L)	---------long	---------integer	---------4
# L	---------unsigned long	---------long	---------4
# q	---------long long	---------long	---------8
# Q	---------unsigned long long	---------long	---------8
# f	---------float	---------float	---------4
# d	---------double	---------float	---------8
# s	---------char[]	---------string	 ---------
# p	---------char[]	---------string	 ---------
# P	---------void *	---------long	 ---------


# 好在Python提供了一个struct模块来解决bytes和其他二进制数据类型的转换。
# struct的pack函数把任意数据类型变成bytes：
import struct
struct.pack('>I', 10240099)
# b'\x00\x9c@c'
# pack的第一个参数是处理指令，'>I'的意思是：
# >表示字节顺序是big-endian，也就是网络序，I表示4字节无符号整数。
# 后面的参数个数要和处理指令一致。

# unpack把bytes变成相应的数据类型：
struct.unpack('>IH', b'\xf0\xf0\xf0\xf0\x80\x80')
# (4042322160, 32896)
# 根据>IH的说明，后面的bytes依次变为I：4字节无符号整数和H：2字节无符号整数。
# 所以，尽管Python不适合编写底层操作字节流的代码，但在对性能要求不高的地方，利用struct就方便多了。