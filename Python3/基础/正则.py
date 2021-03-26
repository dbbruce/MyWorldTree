# coding:utf-8

# re.match函数
# re.match 尝试从字符串的起始位置匹配一个模式，如果不是起始位置匹配成功的话，match()就返回none。

import re
print(re.match('www', 'www.runoob.com').span())  # 在起始位置匹配        结果：(0, 3)
print(re.match('com', 'www.runoob.com'))         # 不在起始位置匹配      结果：None


# re.search方法
# re.search 扫描整个字符串并返回第一个成功的匹配

import re
print(re.search('www', 'www.runoob.com').span())  # 在起始位置匹配      结果：(0, 3)
print(re.search('com', 'www.runoob.com').span())  # 不在起始位置匹配     结果：(11, 14)

# 匹配对象方法	描述
# group(num=0)	匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。
# groups()	返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。

# match实例
import re
line = "Cats are smarter than dogs"
matchObj = re.match(r'(.*) are (.*?) .*', line, re.M | re.I)
if matchObj:
    print "matchObj.group() : ", matchObj.group()      # 'Cats are smarter than dogs'
    print "matchObj.group(0) : ", matchObj.group(0)    # 'Cats are smarter than dogs'
    print "matchObj.group(1) : ", matchObj.group(1)    # 'Cats'
    print "matchObj.group(2) : ", matchObj.group(2)    # 'smarter'
    print "matchObj.groups()  : ", matchObj.groups()   #  ('Cats', 'smarter')
else:
    print "No match!!"

# search实例
import re
line = "Cats are smarter than dogs";
searchObj = re.search(r'(.*) are (.*?) .*', line, re.M | re.I)
if searchObj:
    print "searchObj.group() : ", searchObj.group()     # 'Cats are smarter than dogs'
    print "searchObj.group(0) : ", searchObj.group(0)   # 'Cats are smarter than dogs'
    print "searchObj.group(1) : ", searchObj.group(1)   # 'Cats'
    print "searchObj.group(2) : ", searchObj.group(2)   # 'smarter'
    print "searchObj.groups() : ", searchObj.groups()   #  ('Cats', 'smarter')
else:
    print "Nothing found!!"


# re.compile 函数
# compile 函数用于编译正则表达式，生成一个正则表达式（ Pattern ）对象，供 match() 和 search() 这两个函数使用。
import re
pattern = re.compile(r'\d+')                    # 用于匹配至少一个数字
m = pattern.match('one12twothree34four')        # 查找头部，没有匹配


# findall
# 在字符串中找到正则表达式所匹配的所有子串，并返回一个列表，如果没有找到匹配的，则返回空列表。
import re
pattern = re.compile(r'\d+')  # 查找数字
result1 = pattern.findall('runoob 123 google 456')
result2 = pattern.findall('run88oob123google456', 0, 10)
print(result1)
print(result2)

# re.finditer
# 和 findall 类似，在字符串中找到正则表达式所匹配的所有子串，并把它们作为一个迭代器返回。
import re
it = re.finditer(r"\d+", "12a32bc43jf3")
for match in it:
    print (match.group())

# re.split
# split 方法按照能够匹配的子串将字符串分割后返回列表，它的使用形式如下：
import re
re.split('\W+', 'runoob, runoob, runoob.')
['runoob', 'runoob', 'runoob', '']
