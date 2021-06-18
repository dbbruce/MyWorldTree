# coding: utf-8
# @Time : 2021/6/16 5:56 下午 
# @Author : DB.Bruce Dong

from RabbitMQ import RabbitMQClient
import json

print("start program")
client = RabbitMQClient()


def callback(ch, method, properties, body):
    msg = body.decode()
    print(msg)
    # 如果处理成功，则调用此消息回复ack，表示消息成功处理完成。
    RabbitMQClient.message_handle_successfully(ch, method)


queue_name = "RetryQueue"
client.start_consume(callback, queue_name, delay=0)
