# coding: utf-8
# @Time : 2021/3/31 2:18 下午 
# @Author : DB.Bruce Dong

# print
# python2
# print >> sys.stderr, 1, 2, 3
# python3
# print(1,2,3, file=sys.stderr)

# 字符串
# python2，Unicode字符串和非Unicode字符，unicode()把对象转换成Unicode字符串，还有str()把对象转换 为非Unicode字符串
# unicode(anything)
# python3，只有一种字符串类型，Unicode字符串，所以str()函数即可完成所有的功能
# str(anything)

# 不等于
# Python2 支持<>作为!=的同义词。
# Python3 只支持!=

# 字典类方法HAS_KEY()
# Python2里，字典对象的has_key()方法用来测试字典是否包 含特定的键(key)。
# a_dictionary.has_key('PapayaWhip')
# Python3不再支持这个方法了。你需要使用 in运算符
# 'PapayaWhip' in a_dictionary

# 返回列表的字典类方法
# Python2
# a_dictionary.keys()
# a_dictionary.items()
# a_dictionary.iterkeys()
# Python3
# list(a_dictionary.keys())
# list(a_dictionary.items())
# iter(a_dictionary.keys())






