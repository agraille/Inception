FROM alpine:3.20.6

RUN apk update && apk add --no-cache \
    php82 php82-fpm php82-mysqli php82-curl php82-json php82-mbstring \
    php82-opcache php82-session php82-zlib php82-phar php82-dom php82-exif \
    php82-fileinfo php82-tokenizer php82-xml php82-pecl-imagick \
    php82-pecl-redis php82-ctype php82-cli \
    curl bash wget unzip mariadb-client

RUN ln -sf /usr/bin/php82 /usr/bin/php || true

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress/wp-content/plugins && \
    curl -o redis-cache.zip -L https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip && \
    unzip redis-cache.zip -d /var/www/wordpress/wp-content/plugins && \
    rm redis-cache.zip

RUN echo "memory_limit = 512M" > /etc/php82/conf.d/memory-limit.ini

RUN wp core download --path=/var/www/wordpress --allow-root

RUN mkdir -p /run/php && adduser -D -g 'www' www

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

COPY tools/entrypoint.sh /entrypoint.sh
COPY tools/wp-config-create.sh /wp-config-create.sh
COPY tools/wp-user.sh /wp-user.sh

RUN chmod +x /entrypoint.sh /wp-config-create.sh /wp-user.sh 

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
