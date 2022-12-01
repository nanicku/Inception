FROM debian:buster

EXPOSE 3306

RUN apt-get update && apt-get install -y \
    mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/runme.sh /

RUN chmod 777 /runme.sh

CMD ["./runme.sh"]