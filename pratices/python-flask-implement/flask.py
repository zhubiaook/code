#!/bin/env python
"""
Flask 实现示例, 只在于演示Flask Web框架的作用
"""

from wsgiref.simple_server import make_server
from typing import Callable, Any, Dict


class Flask():
    def __init__(self):
        self.urls: Dict(str, Callable) = {}

    # 将实例化后的Flask()变成可调用对象
    def __call__(self, environ: Dict[Any, Any], start_response: Callable):
        start_response('200 OK', [('Content-Type', 'text/plain')])
        path = environ['PATH_INFO']
        resp = self.urls.get(path)
        if not resp:
            return [b'404']
        return resp()

    def add_url_rule(self, rule: str, func: Callable) -> None:
        print("add_url_rule")
        self.urls[rule] = func

    def route(self, rule: str) -> Callable:
        print('route is Callable')

        def decorator(func: Callable) -> Callable:
            self.add_url_rule(rule, func)
            return func
        return decorator

    def run(self, host: str = "127.0.0.1", port: int = 9999) -> None:
        # 此处self()相当于__call__()
        # 按照PEP333-WSGI规范，此处的self回调函数必须包含两个变量environ, start_response
        svr = make_server(host, port, self)
        svr.serve_forever()
