#!/bin/env bash

PROJECT_ROOT=$(dirname ${BASH_SOURCE[0]})/../../..
SCRIPT_ROOT=$(dirname ${BASH_SOURCE[0]})

source ${PROJECT_ROOT}/common.sh
source ${SCRIPT_ROOT}/environment.sh

# 安装
install() {
  # 配置MariaDB Yum源
  cat << EOF > /etc/yum.repos.d/mariadb-${MARIADB_VERSION}.repo
[mariadb]
name = MariaDB
baseurl = https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/${MARIADB_VERSION}/${OS}\$releasever-amd64/
module_hotfixes=1
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=0
EOF

  # 安装MariaDB和MariaDB客户端
  yum -y install MariaDB-server MariaDB-client

  # 启动MariaDB, 并设置开机启动
  systemctl enable mariadb
  systemctl start mariadb

  # 设置root初始密码
  mysqladmin -u${MARIADB_ADMIN_USERNAME} password ${MARIADB_ADMIN_PASSWORD}

  status
  info
}

# 卸载
uninstall() {
  set +o errexit
  systemctl stop mariadb
  systemctl disable mariadb
  yum -y remove MariaDB-server MariaDB-client
  rm -rf /var/lib/mysql
  rm -rf /var/log/mariadb
  rm -rf /etc/yum.repos.d/mariadb-${MARIADB_VERSION}.repo
  set -o errexit
  log_info "uninstall MariaDB successfully"
}

# 状态检查
status() {
  systemctl is-active mariadb &>/dev/null || {
    log_fatal "mariadb failed to start, maybe not installed properly"
  }
  mysql -u${MARIADB_ADMIN_USERNAME} -p${MARIADB_ADMIN_PASSWORD} -e quit &>/dev/null || {
    log_fatal "can not login with root, mariadb maybe not initialized properly"
  }
  log_info "install MariaDB successfully"
}

# 安装后打印必要信息
info() {
  log_info "MariaDB Login: mysql -h127.0.0.1 -u${MARIADB_ADMIN_USERNAME} -p${MARIADB_ADMIN_PASSWORD}"
}

if [[ "$#" -eq 1 ]]; then
  "$1"
fi
