    
FROM alpine:3.16

WORKDIR /tmp

COPY tools/wp-setup.sh /bin/

# Install the neccessary packages to run wordpress operations
RUN apk update \
    && apk add --no-cache php php-fpm php-mysqli php-phar php-tokenizer \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /tmp/wp-cli.phar\
    && mv /tmp/wp-cli.phar /usr/local/bin/wp \
    && chmod +x /bin/wp-setup.sh \
    && echo -e "\nlisten = 0.0.0.0:9000" >> /etc/php8/php-fpm.d/www.conf

ENTRYPOINT [ "wp-setup.sh" ]
CMD [ "php-fpm8", "-F"]