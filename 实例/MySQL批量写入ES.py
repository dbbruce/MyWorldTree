# coding: utf-8
# @Time : 2021/5/21 4:35 下午 
# @Author : DB.Bruce Dong
# python2.7

from elasticsearch import Elasticsearch
from elasticsearch import helpers
import MySQLdb
import time

# 连接ES
es = Elasticsearch(
    ['127.0.0.1'],
    port=9200
)

# 连接MySQL
print("Connect to mysql...")
m_conn = MySQLdb.connect(host="192.168.1.57", user="cmdb", passwd="1234456", db="cmdb_qa", charset="utf8")
m_cursor = m_conn.cursor()

try:
    num_id = 0
    while True:
        s = time.time()
        # 查询数据
        sql = "select id ,receiver_info,receiver_username,receiver_name,send_type,type_msg,source_platform,msg_subject,content,create_time,deal_time,status,status_content,alarm_target,alarm_tag,alarm_flag from k_total_message_record LIMIT {}, 100000".format(num_id*100000)
        m_cursor.execute(sql)
        query_results = m_cursor.fetchall()

        if not query_results:
            print("MySQL查询结果为空 num_id=<{}>".format(num_id))
            break
        else:
            actions = []
            for line in query_results:
            # 拼接插入数据结构
                action = {
                    "_index": "alarmmessages",
                    "_type": "alarm",
                    "_id":line[0],
                    "_source": {
                        "msg_id": line[0],
                        "receiver_info": line[1],
                        "receiver_username": line[2],
                        "receiver_name": line[3],
                        "send_type": line[4],
                        "type_msg": line[5],
                        "source_platform": line[6],
                        "msg_subject": line[7],
                        "content": line[8],
                        "create_time": line[9],
                        "deal_time": line[10],
                        "status": line[11],
                        "status_content": line[12],
                        "alarm_target": line[13],
                        "alarm_tag": line[14],
                        "alarm_flag": line[15],
                    }
                }
                # 形成一个长度与查询结果数量相等的列表
                actions.append(action)
            # 批量插入
            a = helpers.bulk(es, actions)
            e = time.time()
            print("{} {}s".format(a, e-s))
        num_id += 1

finally:
    m_cursor.close()
    m_conn.close()
    print("MySQL connection close...")
