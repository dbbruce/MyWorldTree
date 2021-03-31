# coding: utf-8
# @Time : 2021/3/31 5:52 下午 
# @Author : DB.Bruce Dong

# 1、namedtuple() --- 创建命名元组子类的工厂函数
from collections import namedtuple
person = ('name', 'age', 'sex', 'mail')
Person = namedtuple('Person', person, verbose=True)
p = Person('changyubiao', 18, "male", '931367095@qq.com')
print(type(p))
print(p.name, p.age, p.sex, p.mail)



# 2、deque --- 类似列表(list)的容器，实现了在两端快速添加(append)和弹出(pop)
import collections
queue = collections.deque()
queue.append('a')   # 末尾写入
queue.appendleft('A')  # 首部写入
queue.extend(['D', 'E'])  # 末尾写入
queue.extendleft(['c', 'd']) # 首部写入
print(queue.pop())  # 末尾弹出
print(queue.popleft()) # 首部弹出





# 3、ChainMap --- 类似字典(dict)的容器类，将多个映射集合到一个视图里面
a = {"x":1, "z":3}
b = {"y":2, "z":4}
c = collections.ChainMap(a,b)
# ChainMap({'x': 1, 'z': 3}, {'y': 2, 'z': 4})
print(c['x'])
print(c['y'])
print(c['z']) # key重复，哪个在前面，使用哪个值; a的z在前面，z就为a的值；



# 4、Counter --- 统计器，字典的子类，提供了可哈希对象的计数功能
colors = ['red', 'blue', 'red', 'green', 'blue', 'blue']
c = collections.Counter(colors)
# Counter({'red': 2, 'blue': 3, 'green': 1})

# 5、OrderedDict --- 有序字典（字典无序），字典的子类，保存了他们被添加的顺序
d1 = collections.OrderedDict()
d1['a'] = 'A'
d1['b'] = 'B'
d1['c'] = 'C'
d1['1'] = '1'
d1['2'] = '2'

# 6、defaultdict --- 字典值提供默认类型，字典的子类，提供了一个工厂函数，为字典查询提供一个默认值
s = [('red', 1), ('blue', 2), ('red', 3), ('blue', 4), ('red', 1), ('blue', 4)]
d = collections.defaultdict(set)
for k, v in s:
  d[k].add(v)

# 7、UserDict --- 封装了字典对象，简化了字典子类化，数据通过UserDict实例的data属性存取；
# collections.Userdict()创建的字典所占空间是普通的dict字典的1/4，但前者还会封装一个data的实例
d0 = dict(a=1, b=2)
d1 = collections.UserDict(d0)
import sys
sys.getsizeof(d0)
# 248
sys.getsizeof(d1)
# 64
sys.getsizeof(d1.data)
# 248

# 8、UserList --- 封装了列表对象，简化了列表子类化，模拟一个列表。
# 这个实例的内容被保存为一个正常列表，通过 UserList 的 data 属性存取
l1 = ['a', 'b', 'c', 'd', 'e', 'f']
import sys
l0 = collections.UserList(l1)
sys.getsizeof(l1)
# 104
sys.getsizeof(l0)
# 48
sys.getsizeof(l0)
# 104

# 9、UserString --- 封装了列表对象，简化了字符串子类化
# 模拟一个字符串对象。这个实例对象的内容保存为一个正常字符串，通过 UserString 的 data 属性存取
import sys
s0 = 'abacdef'
s1 = collections.UserList(s0)
sys.getsizeof(s1)
# 48
sys.getsizeof(s0)
# 56
