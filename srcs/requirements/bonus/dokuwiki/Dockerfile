
FROM alpine:3.16 as stage

WORKDIR /tmp
COPY conf/www.conf /etc/php8/php-fpm.d/www.conf
COPY /tools/dokuWiki-install.sh /bin/dokuWiki-install.sh

# Download dokuWiki
RUN apk update \
    && apk add wget tar php php-gd php-fpm php-xml php-session php-json \
    && chmod +x /bin/dokuWiki-install.sh
    
ENTRYPOINT [ "dokuWiki-install.sh" ]
CMD [ "php-fpm8", "-F" ]