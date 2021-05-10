# coding: utf-8
# @Time : 2021/5/10 1:19 下午 
# @Author : DB.Bruce Dong

from django.utils._os improt safe_join

# safe_join，暂时理解为，根据不同的操作系统，返回适应当前系统的文件路径;比如windows和linux路径不同；

location = ''
safe_join(location, 'fi.txt')
