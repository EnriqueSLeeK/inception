
FROM alpine:3.16

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/ftp-user.sh /bin/ftp-user.sh

RUN apk update \
    && apk add vsftpd shadow \
    && chmod +x /bin/ftp-user.sh

ENTRYPOINT [ "ftp-user.sh" ]
CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]