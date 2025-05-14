#!/bin/bash
set -e

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php déjà présent, skip."
    exit 0
fi

echo "Création du fichier wp-config.php..."

if [ -z "$WORDPRESS_DB_NAME" ] && [ -z "$MYSQL_DATABASE" ]; then
    echo "ERREUR: La variable WORDPRESS_DB_NAME ou MYSQL_DATABASE doit être définie"
    exit 1
fi

if [ -z "$WORDPRESS_DB_USER" ] && [ -z "$MYSQL_USER" ]; then
    echo "ERREUR: La variable WORDPRESS_DB_USER ou MYSQL_USER doit être définie"
    exit 1
fi

if [ -z "$WORDPRESS_DB_PASSWORD" ] && [ -z "$MYSQL_PASSWORD" ]; then
    echo "ERREUR: La variable WORDPRESS_DB_PASSWORD ou MYSQL_PASSWORD doit être définie"
    exit 1
fi

DB_NAME=${WORDPRESS_DB_NAME:-$MYSQL_DATABASE}
DB_USER=${WORDPRESS_DB_USER:-$MYSQL_USER}
DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-$MYSQL_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST:-"mariadb:3306"}

echo "Configuration avec:"
echo "- Base de données: $DB_NAME"
echo "- Utilisateur: $DB_USER"
echo "- Hôte: $DB_HOST"

# Génération des clés de sécurité
AUTH_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
SECURE_AUTH_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
LOGGED_IN_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
NONCE_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
AUTH_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
SECURE_AUTH_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
LOGGED_IN_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
NONCE_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)

cat > /var/www/wordpress/wp-config.php <<EOF
<?php
// ** Réglages MySQL - Vous pouvez obtenir ces informations auprès de votre hébergeur ** //
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');
define('DB_HOST', '$DB_HOST');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// ** Clés uniques d'authentification et salage ** //
define('AUTH_KEY',         '$AUTH_KEY');
define('SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY');
define('LOGGED_IN_KEY',    '$LOGGED_IN_KEY');
define('NONCE_KEY',        '$NONCE_KEY');
define('AUTH_SALT',        '$AUTH_SALT');
define('SECURE_AUTH_SALT', '$SECURE_AUTH_SALT');
define('LOGGED_IN_SALT',   '$LOGGED_IN_SALT');
define('NONCE_SALT',       '$NONCE_SALT');

define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_CLIENT', 'phpredis');

// ** Préfixe de table ** //
\$table_prefix = 'wp_';

// ** Débogage ** //
define('WP_DEBUG', false);

// ** Chemin absolu vers le dossier de WordPress ** //
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

// ** Inclusion du fichier de configuration de WordPress ** //
require_once ABSPATH . 'wp-settings.php';
EOF

echo "wp-config.php créé avec succès."
