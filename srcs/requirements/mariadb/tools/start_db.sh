#!/bin/sh

# Install db if necessary
[[ -d "/var/lib/mysql/mysql" ]] || \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

tmp=`mktemp`

cat << EOF > $tmp

FLUSH PRIVILEGES;
USE mysql;
CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME;
CREATE USER IF NOT EXISTS $MYSQL_USER IDENTIFIED BY '$MYSQL_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO $MYSQL_USER;
DROP DATABASE IF EXISTS test;

EOF

[ -d /var/lib/mysql/$MYSQL_DB_NAME ] \
    || ( /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < $tmp \
    && /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < /tmp/sqldump.sql )

rm $tmp && rm /tmp/sqldump.sql

mysqld --user=mysql --datadir=/var/lib/mysql

# Start mysql/mariadb using the mysql created during the mariadb installation
