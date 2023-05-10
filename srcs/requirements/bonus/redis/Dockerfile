
FROM alpine:3.16

RUN apk update \
    && apk add redis \
    && sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis.conf

CMD [ "redis-server", "--protected-mode no" ]