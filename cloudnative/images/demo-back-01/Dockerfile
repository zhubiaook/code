FROM alpine:3.15
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && apk upgrade \
    && apk add curl \
    && apk add tree
ADD demo-back-01 /opt/
ENTRYPOINT /opt/demo-back-01
