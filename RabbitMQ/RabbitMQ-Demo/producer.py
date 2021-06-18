# coding: utf-8
# @Time : 2021/6/16 5:56 下午 
# @Author : DB.Bruce Dong

from RabbitMQ import RabbitMQClient

print("start program")
client = RabbitMQClient()
msg1 = '{"key":"value"}'
client.publish_message('test-delay', msg1, delay=1, TTL=10000)
print("message send out")
