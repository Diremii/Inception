FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget

RUN apt-get install -y \
    php-fpm \
    php-mysql \
    mariadb-client

WORKDIR /var/www

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /auto_config.sh
RUN chmod +x /auto_config.sh



ENTRYPOINT ["/auto_config.sh"]