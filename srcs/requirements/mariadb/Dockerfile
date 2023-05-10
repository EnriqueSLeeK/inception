
FROM alpine:3.16

COPY tools/start_db.sh /bin/
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY conf/sqldump.sql /tmp/sqldump.sql

# Intall and create the mysqld directory for mysql, then give the right
# permissions to start_db script
RUN apk update && apk add --no-cache mariadb mariadb-client && \ 
        rm -f /var/cache/apk/* && \
        mkdir -p /run/mysqld && \
        chown -R mysql:mysql /run/mysqld && \
        chmod +x /bin/start_db.sh

ENTRYPOINT [ "start_db.sh" ]
#CMD ["mysqld" ,"--user=mysql" ,"--datadir=/var/lib/mysql"]