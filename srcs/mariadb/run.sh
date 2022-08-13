#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

# MYSQL_DATABASE=${MYSQL_DATABASE:-""}
# MYSQL_USER=${MYSQL_USER:-""}
# MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

cat << EOF > config.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DATABASE;
CREATE USER IF NOT EXISTS '$WORDPRESS_DATABASE_USER'@'localhost' IDENTIFIED BY '$WORDPRESS_DATABASE_PASS';
GRANT ALL ON $WORDPRESS_DATABASE.* TO '$WORDPRESS_DATABASE_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < config.sql
# /usr/bin/mysqld --user=mysql < config.sql
# rm -f config.sql

mariadbd

#https://server-talk.tistory.com/373
#https://gafani.tistory.com/entry/MariaDBMySQL-%EC%9B%90%EA%B2%A9%EC%97%90%EC%84%9C-%EC%A0%91%EA%B7%BC%EC%9D%B4-%EA%B0%80%EB%8A%A5%ED%95%98%EB%8F%84%EB%A1%9D-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0
# exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@

# mysqld_safe