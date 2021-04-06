# coding: utf-8
# @Time : 2021/4/6 6:23 下午 
# @Author : DB.Bruce Dong

# 类命名空间
# 创建一个类就会创建一个类的名称空间，用来存储类中定义的所有名字，这些名字称为类的属性

# 对象、实例的命名空间
# 创建一个对象/实例就会创建一个对象/实例的名称空间，存放对象/实例的名字，称为对象/实例的属性

# 面向对象的组合用法
# 软件重用的重要方式除了继承之外还有另外一种方式，即：组合
# 组合指的是，在一个类中以另外一个类的对象作为数据属性，称为类的组合

class Weapon:
    def prick(self, obj):  # 这是该装备的主动技能,扎死对方
        obj.life_value -= 500  # 假设攻击力是500


class Person:  # 定义一个人类
    role = 'person'  # 人的角色属性都是人

    def __init__(self, name):
        self.name = name  # 每一个角色都有自己的昵称;
        self.weapon = Weapon()  # 给角色绑定一个武器;


egg = Person('egon')
egg.weapon.prick()


# egg组合了一个武器的对象，可以直接egg.weapon来使用组合类中的所有方法

# 面向对象的三大特性
# 继承、多态、封装

# 继承
# 继承是一种创建新类的方式，在python中，新建的类可以继承一个或多个父类，父类又可称为基类或超类，新建的类称为派生类或子类
# 派生
# 当然子类也可以添加自己新的属性或者在自己这里重新定义这些属性（不会影响到父类），
# 需要注意的是，一旦重新定义了自己的属性且与父类重名，那么调用新增的属性时，就以自己为准了。

# 抽象类与接口类
# 接口类
# 继承有两种用途：
# 一：继承基类的方法，并且做出自己的改变或者扩展（代码重用）
# 二：声明某个子类兼容于某基类，定义一个接口类Interface，接口类中定义了一些接口名（就是函数名）且并未实现接口的功能，
# 子类继承接口类，并且实现接口中的功能

# 抽象类
# 与java一样，python也有抽象类的概念但是同样需要借助模块实现，抽象类是一个特殊的类，它的特殊之处在于只能被继承，不能被实例化

# 继承顺序
# 经典类，没有继承object；多继承情况下，会按照深度优先方式查找；
# 新式类，当前类或者父类继承object；多继承情况下，会按照广度优先方式查找；
# python会计算出一个方法解析顺序(MRO)列表，这个MRO列表就是一个简单的所有基类的线性顺序列表
# F.mro() #等同于F.__mro__

# 多态
# 多态指的是一类事物有多种形态


# 封装
# 隐藏对象的属性和实现细节，仅对外提供公共访问方式。
# 封装原则
# 1. 将不需要对外提供的内容都隐藏起来；
# 2. 把属性都隐藏，提供公共方法对其访问。


# property属性 （个人理解就是方法，可以按照属性去访问）
# 将一个类的函数定义成特性以后，对象再去使用的时候obj.name,根本无法察觉自己的name是执行了一个函数然后计算出来的，
# 这种特性的使用方式遵循了统一访问的原则


# 实例方法
# 1、第一个参数必须是实例对象，该参数名一般约定为“self”，通过它来传递实例的属性和方法（也可以传类的属性和方法）；
# 2、调用：只能由实例对象调用。

# 类方法
# 定义： @classmethod+cls
# 1、使用装饰器@classmethod。
# 2、第一个参数必须是当前类对象，该参数名一般约定为“cls”，通过它来传递类的属性和方法（不能传实例的属性和方法）；
# 调用：
# 实例对象和类对象都可以调用。
# 实例：
class ClassTest(object):
    __num = 0

    @classmethod
    def addNum(cls):
        cls.__num += 1

    @classmethod
    def getNum(cls):
        return cls.__num

    # 这里我用到魔术函数__new__，主要是为了在创建实例的时候调用人数累加的函数。
    def __new__(self):
        ClassTest.addNum()
        return super(ClassTest, self).__new__(self)


class Student(ClassTest):
    def __init__(self):
        self.name = ''


a = Student()
b = Student()
print(ClassTest.getNum())

# 静态方法
# 定义：
# 1、使用装饰器@staticmethod。
# 2、参数随意，没有“self”和“cls”参数
# 3、但是方法体中不能使用类或实例的任何属性和方法；
# 调用：
# 1、实例对象和类对象都可以调用。
import time


class TimeTest(object):
    def __init__(self, hour, minute, second):
        self.hour = hour
        self.minute = minute
        self.second = second

    @staticmethod
    def showTime():
        return time.strftime("%H:%M:%S", time.localtime())


print(TimeTest.showTime())
t = TimeTest(2, 10, 10)
nowTime = t.showTime()
print(nowTime)
