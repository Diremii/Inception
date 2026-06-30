FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install mariadb-server -y

COPY conf/50-conf.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/script.sh"]
CMD ["mariadbd"]