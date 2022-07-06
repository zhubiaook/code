#!/usr/bin/env python
"""
python socket server
"""

import socket
import time
import re


def run(host: str, port: int):
    # 创建socket实例
    s = socket.socket()
    # 绑定监听地址
    s.bind((host, port))
    # 监听
    s.listen()

    while True:
        # 阻塞等待客户端连接
        client, addr = s.accept()
        print("client established connect: ", addr)
        # 同时只能处理一个连接，若要处理多个连接需要使用多路复用
        while True:
            # 阻塞等待收到客户端的消息
            recv_msg = client.recv(1024).decode()
            if re.match("exit", recv_msg):
                print("client close connect: ", addr)
                send_msg = "close connection"
                client.send(send_msg.encode())
                time.sleep(1)
                client.close()
                break
            print(recv_msg)
            send_msg = "receive message: " + recv_msg
            client.send(send_msg.encode())
    s.close()


if __name__ == '__main__':
    run("0.0.0.0", 9988)
