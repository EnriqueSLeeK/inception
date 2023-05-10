
FROM alpine:3.16 as stage

RUN apk update \
    && apk add wget tar \
    && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -O /tmp/adminer-4.8.1.php
    
FROM alpine:3.16 as prod

COPY --from=stage /tmp/adminer-4.8.1.php /var/www/html/adminer/adminer.php
COPY conf/www.conf /etc/php8/php-fpm.d/www.conf

RUN apk update \
    && apk add php php-fpm php-mysqli php-session

CMD [ "php-fpm8", "-F"]