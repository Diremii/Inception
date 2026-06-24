#!/bin/bash

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306" \
        --path="/var/www/wordpress"
fi

if ! wp core is-installed --allow-root --path="/var/www/wordpress"; then
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path="/var/www/wordpress"
fi

if ! wp user get "$WP_USER" --allow-root --path="/var/www/wordpress" > /dev/null 2>&1; then
    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=subscriber \
        --path="/var/www/wordpress"
fi

exec php-fpm8.2 -F
