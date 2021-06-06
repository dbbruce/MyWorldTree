# coding: utf-8
# @Time : 2021/6/6 11:47 上午 
# @Author : DB.Bruce Dong

# !/usr/bin/env python
import pika
import time

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
print(' [*] Waiting for messages. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body.decode())
    time.sleep(body.count(b'.'))
    print(" [x] Done")
    ch.basic_ack(delivery_tag=method.delivery_tag)


# 一次只能接收并处理一个消息
channel.basic_qos(prefetch_count=1)
# channel.basic_consume(queue='task_queue', on_message_callback=callback)
channel.basic_consume(callback, queue='task_queue')

channel.start_consuming()
