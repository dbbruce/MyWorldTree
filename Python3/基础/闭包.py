# coding:utf-8

# 闭包函数
# 定义
# 外部函数中定义一个内部函数
# 内部函数中使用外部函数的局部变量
# 外部函数将内部函数作为返回值返回
# 返回的函数就称为闭包

def outer():
	sum = 0
	# 外部函数里面定义一个内部函数
	def inner(a_in):
		# 内部函数中使用外部函数的局部变量
		nonlocal sum  # 在内部函数中使用外部函数的局部变量，需要使用nonlocal声明
		total=sum +  a_in
		return total
	# 外部函数将内部函数作为返回值返回
	return inner  # 不加括号，返回的函数就称为闭包

s_custom = outer()  # s_custom实际上就是inner()
print(s_custom(10))
# 运行结果：10
print(s_custom(30))
# 运行结果：30
