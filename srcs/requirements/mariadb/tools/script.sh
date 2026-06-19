#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialisation uniquement si la DB n'existe pas encore
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation MariaDB..."

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe --skip-networking &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

    mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

    mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"

    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    mysql -e "FLUSH PRIVILEGES;"

    mysqladmin -uroot shutdown

    wait "$pid" || true
fi

echo "Démarrage MariaDB..."
exec mysqld_safe