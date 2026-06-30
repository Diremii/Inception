#!/bin/bash
set -e

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    log "Initialisation MariaDB..."

    # Lance mariadbd en arriere-plan, sans reseau, juste pour l'init
    mariadbd -u mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    pid="$!"

    # Attend que le serveur soit pret a accepter des commandes via le socket
    for i in $(seq 1 30); do
        if mariadb-admin --socket=/run/mysqld/mysqld.sock ping --silent 2>/dev/null; then
            break
        fi
        sleep 1
    done

    mariadb -u root --socket=/run/mysqld/mysqld.sock << EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # Arrete proprement ce mariadbd temporaire avant de relancer le "vrai"
    mariadb-admin --socket=/run/mysqld/mysqld.sock shutdown
    wait "$pid"
fi

exec "$@"