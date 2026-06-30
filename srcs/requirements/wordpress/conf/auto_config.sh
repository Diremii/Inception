#!/bin/bash

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    log "Setting up Wp"

    wp --allow-root core download --path=/var/www/wordpress

    log "Setting up config" 
    wp --allow-root config create \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb \
        --path=/var/www/wordpress

    log "Installing Core"
    wp --allow-root core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path=/var/www/wordpress

    log "Creating User"
    wp --allow-root user create $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=subscriber \
        --path=/var/www/wordpress
fi


exec php-fpm8.2 -F
