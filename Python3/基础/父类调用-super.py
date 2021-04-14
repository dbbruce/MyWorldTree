# coding: utf-8
# @Time : 2021/4/7 4:06 下午 
# @Author : DB.Bruce Dong

# super(子类，self).父类方法()
# 1、super()是为了类继承之后为了调用被重写的父类方法而使用，而且它应该还能通过参数精地准指出用的是哪一代父类的方法，
# super(a,self).XXX, 调用类a的父类方法XXX；
# 2、父类多次被调用时只执行一次， 优化了执行逻辑

# Python中的super()方法设计目的是用来解决多重继承时父类的查找问题，
# 所以在单重继承中用不用 super 都没关系；但是，使用 super() 是一个好的习惯。一般我们在子类中需要调用父类的方法时才会这么用


class A(object):   # Python2.x 记得继承 object
    def add(self, x):
         y = x+1
         print(y)
class B(A):
    def add(self, x):
        super(B, self).add(x)
b = B()
b.add(2)  # 3