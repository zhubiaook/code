# OS version
eval $(cat /etc/os-release)
readonly OS=${ID:-centos}
readonly OS_VERSION=${VERSION_ID:-8}

# 通用的密码，便于记忆
readonly PASSWORD=${PASSWORD:-'Demo123$%^'}

# Redis配置信息
readonly REDIS_VERSION=${REDIS_VERSION:-''}
readonly REDIS_HOST=${REDIS_HOST:-127.0.0.1}
readonly REDIS_PORT=${REDIS_PORT:-6379}
readonly REDIS_USERNAME=${REDIS_USERNAME:-''}
readonly REDIS_PASSWORD=${REDIS_PASSWORD:-${PASSWORD}}
