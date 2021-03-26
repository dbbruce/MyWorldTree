# coding:utf-8

# 1、Python里面所有的名称都是区分大小写的:变量名、函数名、 类名、模块名称、异常名称。
# 如果你可以获取它、设置它、调用它、构建它、导入它、或者抛出它，那么它就是区分大小写的。

# 2、isinstance() 函数判断某个值或变量是否为给定某个类型

# 3、元组，a_set = {1, 2, 3};
# 拼接
# a_set.update({4,5,6,})
# a_set.update([4,5,6,])

# 常用方法
# add()	为集合添加元素
# clear()	移除集合中的所有元素
# copy()	拷贝一个集合
# difference()	返回多个集合的差集
# difference_update()	移除集合中的元素，该元素在指定的集合也存在。
# discard()	删除集合中指定的元素
# intersection()	返回集合的交集
# intersection_update()	返回集合的交集。
# isdisjoint()	判断两个集合是否包含相同的元素，如果没有返回 True，否则返回 False。
# issubset()	判断指定集合是否为该方法参数集合的子集。
# issuperset()	判断该方法的参数集合是否为指定集合的子集
# pop()	随机移除元素
# remove()	移除指定元素
# symmetric_difference()	返回两个集合中不重复的元素集合。
# symmetric_difference_update()	移除当前集合中在另外一个指定集合相同的元素，并将另外一个指定集合中不同的元素插入到当前集合中。
# union()	返回两个集合的并集
# update()	给集合添加元素

# 4、glob 模块是 Python 标准库中的另一个工具，它可以通过编程的 方法获得一个目录的内容，并且它使用熟悉的命令行下的通配 符。
# import glob
# glob.glob('*.py')  # 显示全部py文件

# 5、