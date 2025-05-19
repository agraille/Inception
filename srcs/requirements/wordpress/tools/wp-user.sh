#!/bin/bash
set -ex

if ! wp user get "$WORDPRESS_SECOND_USER" --path=/var/www/wordpress --allow-root > /dev/null 2>&1; then
  wp user create \
    $WORDPRESS_SECOND_USER \
    $WORDPRESS_SECOND_USER_EMAIL \
    --user_pass="$(cat /run/secrets/wordpress_second_user_password)" \
    --role=author \
    --path=/var/www/wordpress \
    --allow-root
fi
