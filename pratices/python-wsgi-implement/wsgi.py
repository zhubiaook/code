"""
WSGI的简单实现，仅能处理HTTP请求
相当于一个能处理Python动态资源的简易WEB服务器
"""

from typing import Callable, Tuple, Optional, List, Dict, Any, Sequence
import sys
import socket
import select


class WSGIServer():
    def __init__(self, server_address: Tuple[str, int]):
        self.application: Optional[Callable] = None
        self.server_address: Tuple(str, int) = server_address
        self.server_name: str = self.server_address[0]
        self.server_port: int = self.server_address[1]
        self.request_path: str = "/"
        self.request_method: str = "GET"
        self.request_headers: List[str] = []
        self.response_headers: List[str] = []
        self.status: str = ''
        self.socket = None

    def server_forever(self) -> None:
        """
        使用epoll实现多客户端同时连接
        """
        self.socket_server()
        server_socket = self.socket
        # 采用epoll同时处理多客户端连接
        epoll = select.epoll()
        # 将socket文件描述符注册到epoll队列中
        epoll.register(server_socket.fileno(), select.EPOLLIN)

        # 循环处理epoll队列中有事件产生的文件描述符
        clients: Dict[int, Any] = {}
        while True:
            # 客户端socket对象与该对象文件描述符的映射
            # epoll阻塞等待队列中出现有事件产生的文件描述符
            events = epoll.poll(timeout=-1)
            for fd, event in events:
                if fd == server_socket.fileno():
                    # 与客户端建立连接
                    client_socket, addr = server_socket.accept()
                    client_socket.setblocking(0)
                    # 将客户端socket文件描述符注册到epoll队列中
                    epoll.register(client_socket.fileno(), select.EPOLLIN)
                    clients[client_socket.fileno()] = {"socket": client_socket, "addr": addr}
                elif event & select.EPOLLIN:
                    addr = clients.get(fd).get('addr')
                    # 此处未判断是否读完，待后续完善
                    client_socket = clients.get(fd).get("socket")
                    recv = client_socket.recv(1024)
                    self.get_request(recv, addr)
                    print(str(addr) + " " + self.request_path)
                    app_resp = self.handler_request()
                    resp = self.finish_response(app_resp)
                    client_socket.sendall(resp.encode())
                    epoll.unregister(fd)
                    client_socket.close()

                elif event & select.EPOLLHUP:
                    client_socket = clients.get(fd).get("socket")
                    epoll.unregister(fd)
                    client_socket.close()

    def socket_server(self) -> None:
        # AF_INET: IPv4
        # SOCK_STREAM: TCP
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # 设置TCP处于TIME_WAIT状态时进行端口复用
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.bind(self.server_address)
        self.socket.listen()
        # 设置为非阻塞模式
        self.socket.setblocking(0)

    def set_app(self, app: Callable) -> None:
        self.application = app

    def get_environ(self) -> Dict[str, Any]:
        """
        构造响应的 WSGI 环境变量
        """
        env = {
            'wsgi.version': (1, 0),
            'wsgi.url_scheme': 'http',
            'wsgi.errors': sys.stderr,
            'REQUEST_METHOD': self.request_method,
            'PATH_INFO': self.request_path,
            'SERVER_NAME': self.server_name,
            'SERVER_PORT': str(self.server_port),
        }
        return env

    def get_request(self, request: bytes, client_address: Tuple[str, int]) -> None:
        """
        解析HTTP请求
        """
        req = request.decode().strip().split("\n")
        req_line = req[0].strip().split(" ")
        req_header_tmp = req[1:]
        req_header = []
        for i in req_header_tmp:
            h = i.split(": ")
            req_header.append((h[0].strip(), h[1].strip()))
        self.request_method = req_line[0]
        self.request_path = req_line[1]

    def handler_request(self) -> Sequence:
        """
        调用后端Python函数获取响应
        """
        env = self.get_environ()
        return self.application(env, self.start_response)

    def start_response(self, resp_status: str, header: List[Any]) -> None:
        """
        构建响应头部
        """
        resp_line = 'HTTP/1.1 ' + resp_status + '\n'
        resp_header = ""
        for i in header:
            resp_header += i[0] + ": " + i[1] + '\n'
        self.response_headers = resp_line + resp_header

    def finish_response(self, body: Any) -> str:
        """
        构建HTTP响应报文
        """
        resp_body = str(body)
        resp = self.response_headers + "\n" + resp_body + "\n\n"
        return resp


def make_server(host: str, port: int, app: Callable) -> WSGIServer:
    server = WSGIServer((host, port))
    server.set_app(app)
    return server
