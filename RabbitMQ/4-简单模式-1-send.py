# coding: utf-8
# @Time : 2021/6/4 12:05 上午 
# @Author : DB.Bruce Dong

import pika
# 连接rabbitmq-connection
# auth = pika.PlainCredentials('dxb', '123456')
connection = pika.BlockingConnection(pika.ConnectionParameters(host='127.0.0.1', port=5672))
# 声明通道-channel
channel = connection.channel()
# 声明队列-queue
channel.queue_declare(queue='queue1')
# 发布消息
channel.basic_publish(
    exchange='',
    routing_key='queue1',  # 指定队列名称
    body='helloword-msg'
)
print "【x】发送helloworld"
# 关闭连接
connection.close()
