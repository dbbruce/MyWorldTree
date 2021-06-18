# coding: utf-8
# !/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

channel.queue_declare(queue='task_queue_ttl',
                      durable=True,
                      arguments={
                          'x-message-ttl': 6000,
                                 })
message = ' '.join(sys.argv[1:]) or "Hello World!"
channel.basic_publish(
    exchange='',
    routing_key='task_queue_ttl',
    body=message
)
print(" [x] Sent %r" % message)
connection.close()
