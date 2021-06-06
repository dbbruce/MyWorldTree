# coding: utf-8
# !/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
# queue_declare参数
# 1、队列名
# 2、是否定义持久化
# 3、是否独占本次连接
# 4、是否在不使用的时候自动删除队列
# 5、队列其他参数
channel.queue_declare(queue='task_queue', durable=True)
# 要发送的消息
message = ' '.join(sys.argv[1:]) or "Hello World!"
# basic_publish参数
# 1、交换机名称，如果没有指定使用默认default exchange
# 2、路由key，简单模式可以传递队列名称
# 3、消息其他属性
# 4、消息内容
channel.basic_publish(
    exchange='',
    routing_key='task_queue',
    body=message,
    properties=pika.BasicProperties(
        delivery_mode=2,  # 使消息持久化
    ))
print(" [x] Sent %r" % message)
connection.close()
