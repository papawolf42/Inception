FROM alpine:3.16.1

ARG INIT_PATH=/etc/init.d

#https://www.linuxshelltips.com/install-mariadb-alpine-linux/
RUN apk --no-cache upgrade && apk add mariadb mariadb-client openrc

RUN mkdir -p /run/mysqld && mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld && chown mysql:mysql /var/lib/mysql

ADD ./run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

ENTRYPOINT ["/scripts/run.sh"]
