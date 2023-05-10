#!/bin/sh

# Install wordpress if there is nothing in the directory
[ -f /var/www/html/index.php ] \
    || (echo "Installing wordpress" \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xf latest.tar.gz \
    && mv wordpress/* /var/www/html/ \
    && rm -rf wordpress latest.tar.gz)

# Configure wordpress database connection
[ -f /var/www/html/wp-config.php ] \
  || ( echo "Basic wordpress configuration" \
  && cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php \
  && wp --path="$WORDPRESS_PATH" config set DB_NAME $WORDPRESS_DB_NAME > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set DB_HOST $WORDPRESS_DB_HOST > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set DB_USER $WORDPRESS_DB_USER > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set DB_PASSWORD $WORDPRESS_DB_PASSWORD > /dev/null )

# Verify if redis-cache installed if not install it
[ -f /var/www/html/wp-content/plugins/redis-cache/redis-cache.php ] \
  || ( echo "Redis configuration and installation" \
  && while [ ! -f /var/www/html/wp-content/plugins/redis-cache/redis-cache.php ] \
  && ! wp --path="$WORDPRESS_PATH" plugin install redis-cache --activate ; do sleep 5; done \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_HOST $REDIS_HOST > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_PORT $REDIS_PORT > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_PREFIX "redis-" > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_DATABASE 0 > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_TIMEOUT 1 > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set WP_REDIS_READ_TIMEOUT 1 > /dev/null \
  && wp --path="$WORDPRESS_PATH" config set DB_CACHE true > /dev/null \
  && wp --path="$WORDPRESS_PATH" redis enable )

# Executed the command inside the dockerfile
exec "$@"