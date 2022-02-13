#!/usr/bin/env bash

# 停用firewalld
disable_firewalld() {
  systemctl is-enabled firewalld 2>/dev/null | egrep '(enabled|disabled)' &>/dev/null || {
    return 0
  } 
  systemctl stop firewalld.service
  systemctl disable firewalled.service
}

# 停用SELinux
disable_selinux() {
  [[ -f /etc/selinux/config ]] || {
    return 0
  }
  setenforce 0
  sed -ri 's/^[[:blank:]]*SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config
}
