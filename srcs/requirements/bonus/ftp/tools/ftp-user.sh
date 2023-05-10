#!/bin/sh

mkdir -p /var/ftp/$FTP_USER \
&& adduser -D -G ftp -h /var/ftp/$FTP_USER $FTP_USER \
&& echo "$FTP_USER:$FTP_PASS" | chpasswd \
&& chown $FTP_USER:ftp /var/ftp/$FTP_USER \
&& mount --bind /var/www/html /var/ftp/$FTP_USER

exec "$@"