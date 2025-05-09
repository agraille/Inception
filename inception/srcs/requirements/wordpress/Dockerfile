FROM alpine:3.18

RUN apk update && apk add --no-cache \
    php81 php81-fpm php81-mysqli php81-curl php81-json php81-mbstring \
    php81-opcache php81-session php81-zlib php81-phar php81-dom php81-exif \
    php81-fileinfo php81-tokenizer php81-xml php81-pecl-imagick \
    curl bash wget unzip mariadb-client

RUN mkdir -p /run/php && adduser -D -g 'www' www

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php81/php-fpm.d/www.conf

COPY tools/entrypoint.sh /entrypoint.sh
COPY tools/wp-config-create.sh /wp-config-create.sh

RUN chmod +x /entrypoint.sh /wp-config-create.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
