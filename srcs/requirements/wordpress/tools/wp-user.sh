#!/bin/bash
set -e


if ! wp user get "$WORDPRESS_ADMIN_USER" --path=/var/www/wordpress --allow-root > /dev/null 2>&1; then
  wp user create \
    $WORDPRESS_ADMIN_USER \
    $WORDPRESS_ADMIN_EMAIL \
    --user_pass=$WORDPRESS_ADMIN_PASSWORD \
    --role=administrator \
    --path=/var/www/wordpress \
    --allow-root
fi

if ! wp user get "$WORDPRESS_SECOND_USER" --path=/var/www/wordpress --allow-root > /dev/null 2>&1; then
  wp user create \
    $WORDPRESS_SECOND_USER \
    $WORDPRESS_SECOND_USER_EMAIL \
    --user_pass=$WORDPRESS_SECOND_USER_PASSWORD \
    --role=author \
    --path=/var/www/wordpress \
    --allow-root
fi
