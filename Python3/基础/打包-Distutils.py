# coding: utf-8
# @Time : 2021/3/31 10:08 上午 
# @Author : DB.Bruce Dong

# Python3自带一个名为 Distutils 的打包框架
# Distutils 包含许多功能:
# 构建工具(为你所准备)
# 安装工具(为用户所准 备)
# 数据包格式(为搜索引擎所准备)等

# 1、创建hiFun.py
def hi_dong():
 print("say hi for world")

# 2、建立setup.py文件
from distutils.core import setup
setup(
 name="hi_module",  # pip list 查到的名字
 version="1.0",   # 包的版本号
 author="DB.bruce Dong",
 author_email="dbbruce@163.com",
 py_modules=['hiFun'],  # 模块名称，这里的名字要与脚本名保持一致，这里是import用， import hiFun
)

# 3、执行打包命令
# python setup.py sdist  生成安装包
# [root@Centos7-57 2]# tree ./
# ./
# ├── dist
# │   └── hi_module-1.0.tar.gz
# ├── hiFun.py
# ├── MANIFEST
# └── setup.py

# 4、安装模块
# tar xvf hi_module-1.0.tar.gz
# python setup.py install

# 5、使用模块
import hiFun
hiFun.hi_dong()
# say hi for world