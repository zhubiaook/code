"""
WSGI的实现使用
"""

from wsgi import make_server
from typing import Dict, Any, Callable, Sequence


def application(environ: Dict[Any, Any], start_response: Callable) -> Sequence:
    resp_status = '200 OK'
    resp_header = [
        ('Content-Type', 'text/plain')
    ]
    start_response(resp_status, resp_header)
    resp_body = [{'name': 'Jack'}]
    return resp_body


if __name__ == '__main__':
    server = make_server('127.0.0.1', 9988, application)
    server.server_forever()
