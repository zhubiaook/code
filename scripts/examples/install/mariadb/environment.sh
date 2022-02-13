# OS version
eval $(cat /etc/os-release)
readonly OS=${ID:-centos}
readonly OS_VERSION=${VERSION_ID:-8}

# 通用的密码，便于记忆
readonly PASSWORD=${PASSWORD:-'Demo123$%^'}

# Mariadb
readonly MARIADB_VERSION=${MARIADB_VERSION:-10.5}
readonly MARIADB_HOST=${MARIADB_HOST:-127.0.0.1:3306}
readonly MARIADB_ADMIN_USERNAME=${MARIADB_ADMIN_USERNAME:-root}
readonly MARIADB_ADMIN_PASSWORD=${MARIADB_ADMIN_PASSWORD:-${PASSWORD}}
readonly MARIADB_DATABASE=${MARIADB_DATABASE:-iam}
readonly MARIADB_USERNAME=${MARIADB_USERNAME:-iam}
readonly MARIADB_PASSWORD=${MARIADB_PASSWORD:-${PASSWORD}}
