FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install mariadb-server -y
COPY conf/50-conf.cnf /etc/mysql/mariadb.conf.d/50-conf.cnf
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT ["bash", "/script.sh"]