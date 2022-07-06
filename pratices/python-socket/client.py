#!/usr/bin/env python
"""
python socket client
"""

import socket
import re


def run(server_host: str, server_port: int):
    # 创建socket套接字
    s = socket.socket()
    # 和服务端建立连接
    s.connect((server_host, server_port))

    while True:
        send_msg = input()
        s.send(send_msg.encode())
        recv_msg = s.recv(1024).decode()
        print(recv_msg)
        if re.match("exit", send_msg):
            s.close()
            break


if __name__ == '__main__':
    run("127.0.0.1", 9988)
