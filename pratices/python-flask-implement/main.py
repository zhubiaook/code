#!/bin/env python
from flask import Flask

app = Flask()


@app.route("/")
def index():
    return [b'index']


@app.route("/hello")
def hello():
    return [b'hello']


if __name__ == '__main__':
    app.run("127.0.0.1", 9999)
