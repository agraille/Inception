FROM alpine:3.20.6

RUN apk update && apk add --no-cache \
    php81 php81-fpm php81-mysqli php81-curl php81-json php81-mbstring \
    php81-opcache php81-session php81-zlib php81-phar php81-dom php81-exif \
    php81-fileinfo php81-tokenizer php81-xml php81-pecl-imagick \
    php81-pecl-redis php81-ctype\
    curl bash wget unzip mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress/wp-content/plugins && \
    curl -o redis-cache.zip -L https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip && \
    unzip redis-cache.zip -d /var/www/wordpress/wp-content/plugins && \
    rm redis-cache.zip

RUN echo "memory_limit = 512M" > /etc/php81/conf.d/memory-limit.ini

RUN wp core download --path=/var/www/wordpress --allow-root

RUN mkdir -p /run/php && adduser -D -g 'www' www

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY tools/entrypoint.sh /entrypoint.sh
COPY tools/wp-config-create.sh /wp-config-create.sh
COPY tools/wp-user.sh /wp-user.sh

RUN chmod +x /entrypoint.sh /wp-config-create.sh /wp-user.sh 

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
