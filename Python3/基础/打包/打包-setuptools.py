# coding: utf-8
# @Time : 2021/3/31 5:08 下午 
# @Author : DB.Bruce Dong

# setuptools是Python distutils增强版的集合，它可以帮助我们更简单的创建和分发Python包
# setup.py文件中定义entry_points，可以把脚本变成linux 命令（官方说法是linux的某个服务）

# 一、创建功能包
# 创建一个文件夹demo，在文件夹里创建get_path.py和__init__.py两个文件。
# get_path.py是功能函数，__init__.py是包的标识文件。

# vim get_path.py
import os
def fun():
    print("i am in the path:")
    print(os.getcwd())

# 包结构
# [root@Centos7-57 demo]# tree
# .
# ├── get_path.py
# └── __init__.py

# 二、配置setup.py文件
# 创建setup.py文件，填写必要的打包信息。
# setup.py
#-*- encoding: UTF-8 -*-
from setuptools import setup
setup(
    name = "demo",    # 包名
    version = "0.1",    # 版本信息
    packages = ['demo'],   # 要打包的项目文件夹
    include_package_data=True, # 自动打包文件夹内所有数据
    zip_safe=True,    # 设定项目包为安全，不用每次都检测其安全性
    install_requires = [   # 安装依赖的其他包（测试数据）
        'docutils>=0.3',
        'requests',
    ],
    # 设置程序的入口为path
    # 安装后，命令行执行path相当于调用get_path.py中的fun方法，
    # 配置这个linux就会有一个path命令，相当于执行python文件里的fun方法
    entry_points={
        'console_scripts':[
            'path = demo.get_path:fun'
        ]
    },
)

# 三、打包
# python setup.py sdist
# 打包之后多出两个文件夹，分别是demo.egg-info和dist。
# demo.egg-info是必要的安装信息，而dist中的压缩包就是安装包。

# 四、安装包
# tar xvf demo-0.1.tar.gz
# python setup.py install

# 五、使用包
# linux 控制台
# [root@Centos7-57 dist]# path
# i am in the path:
# /root/1/2/4/dist

from demo import get_path
get_path.fun()
# i am in the path:
# /root/1/2/4/dist/demo-0.1
