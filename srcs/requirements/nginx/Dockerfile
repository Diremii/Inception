FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && mkdir -p /var/run/nginx

RUN openssl req -x509 \
                -nodes \
                -keyout /etc/nginx/ssl/inception.key \
                -out /etc/nginx/ssl/inception.crt \
                -subj "/CN=humontas.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]