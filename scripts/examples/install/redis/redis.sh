#!/usr/bin/env bash

PROJECT_ROOT=$(dirname ${BASH_SOURCE[0]})/../../..
SCRIPT_ROOT=$(dirname ${BASH_SOURCE[0]})

source ${PROJECT_ROOT}/common.sh
source ${SCRIPT_ROOT}/environment.sh

# 安装后打印必要信息
info() {
  log_info "Redis Login: redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_PASSWORD}"
}

# 检查Redis启动状态
status() {
  systemctl is-active redis &>/dev/null || {
    log_fatal "redis failed to start, maybe not installed properly"
  }
  log_info "install redis successfully"
}

# 安装Redis
install() {
  # 安装redis
  yum -y install redis

  # 设置redis密码
  sed -i "s/^# requirepass.*$/requirepass ${REDIS_PASSWORD}/" /etc/redis.conf

  # 停用SELinux和Firewalld
  disable_selinux
  disable_firewalld

  # 启动Redis
  systemctl start redis
  systemctl enable redis

  status
  info
}

# 卸载Redis
uninstall() {
  set +o errexit
  systemctl stop redis
  systemctl disable redis
  yum -y remove redis
  rm -rf /var/lib/redis
  rm -rf /var/log/redis
  set -o errexit
  log_info "uninstall redis successfully"
}

if [[ "$#" -eq 1 ]]; then
  "$1"
fi
