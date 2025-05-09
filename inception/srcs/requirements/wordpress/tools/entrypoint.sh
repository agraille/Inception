#!/bin/bash

set -e
WP_DIR="/var/www/wordpress"

echo "Attente de la connexion à MariaDB..."
until mysqladmin ping -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --silent; do
    echo "En attente de MariaDB..."
    sleep 3
done
echo "MariaDB est prêt!"

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "Téléchargement de WordPress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress $WP_DIR
    rm latest.tar.gz
    ./wp-config-create.sh
fi

echo "Démarrage de PHP-FPM..."
exec php-fpm81 -F
