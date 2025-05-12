#!/bin/bash

set -e
WP_DIR="/var/www/wordpress"

echo "Attente de la connexion à MariaDB..."
MAX_TRIES=30
COUNTER=0
until mysqladmin ping -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --silent; do
    COUNTER=$((COUNTER+1))
    if [ $COUNTER -ge $MAX_TRIES ]; then
        echo "Impossible de se connecter à MariaDB après $MAX_TRIES tentatives. Sortie."
        exit 1
    fi
    echo "En attente de MariaDB (tentative $COUNTER/$MAX_TRIES)..."
    sleep 5
done
echo "MariaDB est prêt!"

echo "Vérification de l'existence de la base de données ${WORDPRESS_DB_NAME}..."
if ! mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "USE ${WORDPRESS_DB_NAME}"; then
    echo "La base de données ${WORDPRESS_DB_NAME} n'existe pas ou n'est pas accessible!"
    exit 1
fi
echo "Base de données ${WORDPRESS_DB_NAME} accessible."

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "Téléchargement de WordPress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -a wordpress/. $WP_DIR/
    rm -rf wordpress latest.tar.gz
    ./wp-config-create.sh
fi

find /var/www/wordpress -type d -exec chmod 755 {} \;
find /var/www/wordpress -type f -exec chmod 644 {} \;
chown -R www:www /var/www/wordpress

echo "Démarrage de PHP-FPM..."
exec php-fpm81 -F
