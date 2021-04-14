# coding: utf-8
# @Time : 2021/4/7 4:03 下午 
# @Author : DB.Bruce Dong

# __new__方法：类级别的方法
# 特性：
# 1.是在类准备将自身实例化时调用，并且至少需要传递一个参数cls, 此参数在实例化时由python解释器自动提供；
# 2.始终是类的静态方法，即使没有被加上静态方法装饰器；
# 3.必须要有返回值，返回实例化出来的实例；在自己实现__new__()
# 时需要注意：可以return父类（通过super(当前类名，cls)）.__new__出来的实例，
# 或者直接是object的__new__出来的实例


class A(object):
    pass
a = A()  # 默认调用父类object的__new__()方法来构造该类的实例
print(a)  # 返回的是<__main__.A object at 0x0000024352732630>
class A(object):
    def __new__(cls):
        "重写__new__方法"
        return "abc"
a = A()
print(a)  # 'abc',实例化对象取决于__new__方法，__new__返回什么就是什么
print(type(a))  # <class 'str'>


# 通过__new__()
# 方法实现单例
class Singleton(object):
    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, "_instance"):
            cls._instance = super(Singleton, cls).__new__(cls)
        return cls._instance
a = Singleton()
b = Singleton()
c = Singleton()
print(a)
print(b)
print(c)
# 输出结果：
# < __main__.Singleton object at 0x000002474C92D550 >
# < __main__.Singleton object at 0x000002474C92D550 >
# < __main__.Singleton object at 0x000002474C92D550 >



# __init__方法：实例级别的方法
# 特性:
# 1.有一个参数self, 该self参数就是__new__() 返回的实例；
# 2.__init__()在__new()的基础上完成初始化动作，不需要返回值；
# 3.若__new__()没有正确返回当前类cls的实例，那__init__()将不会被调用
# 4.创建的每个实例都有自己的属性，方便类中的实例方法调用；

# 对比下面代码理解会更加清晰：
class B():
    def __new__(cls):
        print("__new__方法被执行")
    def __init__(self):
        print("__init__方法被执行")
b = B()
# 结果：
# __new__方法被执行

class B():
    def __new__(cls):
        print("__new__方法被执行")
        return super(B, cls).__new__(cls)
    def __init__(self):
        print("__init__方法被执行")
b = B()
# 结果：
# __new__方法被执行
# __init__方法被执行