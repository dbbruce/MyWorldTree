# coding: utf-8
# @Time : 2021/6/4 12:23 上午 
# @Author : DB.Bruce Dong


import pika, sys, os


def main():
    # auth = pika.PlainCredentials('dxb', '123456')
    connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port=5672))
    channel = connection.channel()

    channel.queue_declare(queue='queue1')
    # 队列接收消息更为复杂。它通过将回调函数订阅到队列来工作。每当我们收到一条消息时，这个回调函数就会被Pika库调用
    def callback(ch, method, properties, body):
        print(" [x] Received %r" % body)

    channel.basic_consume(
        callback,
        queue='queue1',
        no_ack=False
    )
    print(' [*] Waiting for messages. To exit press CTRL+C')
    channel.start_consuming()


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
