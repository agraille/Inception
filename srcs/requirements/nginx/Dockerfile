FROM alpine:3.18

RUN apk update && apk add nginx openssl

RUN mkdir -p /etc/ssl/private /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Inception/CN=localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/wordpress && \
    chown -R nobody:nogroup /var/www/wordpress

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
