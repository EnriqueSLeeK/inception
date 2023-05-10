
# Base docker image
FROM alpine:3.16

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY static_page/index.html /usr/share/nginx/html/static/index.html

# Installation phase
RUN apk update \
    && apk upgrade \
    && apk add nginx openssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/privatekey.key -out /etc/ssl/certificate.crt --subj "/CN=localhost"

# Entrypoint aka the kickstart cmd
CMD [ "nginx", "-g", "daemon off;" ]
