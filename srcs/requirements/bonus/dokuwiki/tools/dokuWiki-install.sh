#!/bin/sh

[ -f /var/www/html/wiki/doku.php ] \
    || ( echo "Installing doku wiki" \
    && wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz -O dokuWiki.tgz \
    && tar -xf dokuWiki.tgz \
    && mv dokuwiki-2023-04-04/* /var/www/html/wiki/ \
    && rm dokuWiki.tgz \
    && rm -r dokuwiki-2023-04-04 \
    && chown nobody:nobody -R /var/www/html/wiki )

exec "$@"