#!/bin/sh

set -e

WP_PATH="/var/www/wordpress"
export HTTP_HOST="$DOMAIN_NAME"

sleep 10

if [ ! -f "$WP_PATH/wp-load.php" ]; then
  echo ">> Téléchargement de WordPress..."
  wp core download --path="$WP_PATH" --allow-root
fi

if [ ! -f "$WP_PATH/wp-config.php" ]; then
  echo ">> Création du fichier wp-config.php..."
  /wp-config-create.sh
fi

if ! wp core is-installed --path="$WP_PATH" --allow-root; then
  echo ">> Installation de WordPress..."
  wp core install --path="$WP_PATH" --allow-root --url=https://$DOMAIN_NAME --title="WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL
  echo ">> Création des utilisateurs..."
  ./wp-user.sh
fi

wp plugin is-active redis-cache --path="$WP_PATH" --allow-root || wp plugin activate redis-cache --path="$WP_PATH" --allow-root

echo ">> Configuration des permissions..."
chown -R www:www /var/www/wordpress

cp /var/www/wordpress/wp-content/plugins/redis-cache/includes/object-cache.php /var/www/wordpress/wp-content/object-cache.php
wp redis enable --path=/var/www/wordpress --allow-root

exec php-fpm82 -F
