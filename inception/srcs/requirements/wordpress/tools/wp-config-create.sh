#!/bin/bash

set -e

# Générer les clés de sécurité
AUTH_KEY=$(head -c 64 /dev/urandom | base64)
SECURE_AUTH_KEY=$(head -c 64 /dev/urandom | base64)
LOGGED_IN_KEY=$(head -c 64 /dev/urandom | base64)
NONCE_KEY=$(head -c 64 /dev/urandom | base64)
AUTH_SALT=$(head -c 64 /dev/urandom | base64)
SECURE_AUTH_SALT=$(head -c 64 /dev/urandom | base64)
LOGGED_IN_SALT=$(head -c 64 /dev/urandom | base64)
NONCE_SALT=$(head -c 64 /dev/urandom | base64)

# Générer le fichier wp-config.php
cat > /var/www/wordpress/wp-config.php <<EOF
<?php
define( 'DB_NAME', getenv('MYSQL_DATABASE') );
define( 'DB_USER', getenv('MYSQL_USER') );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );
define( 'DB_HOST', 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         '$AUTH_KEY' );
define( 'SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY' );
define( 'LOGGED_IN_KEY',    '$LOGGED_IN_KEY' );
define( 'NONCE_KEY',        '$NONCE_KEY' );
define( 'AUTH_SALT',        '$AUTH_SALT' );
define( 'SECURE_AUTH_SALT', '$SECURE_AUTH_SALT' );
define( 'LOGGED_IN_SALT',   '$LOGGED_IN_SALT' );
define( 'NONCE_SALT',       '$NONCE_SALT' );

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF
