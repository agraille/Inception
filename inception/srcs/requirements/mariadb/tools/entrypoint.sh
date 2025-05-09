#!/bin/bash

mkdir -p /docker-entrypoint-initdb.d
chmod -R 755 /docker-entrypoint-initdb.d

echo "Génération du script d'initialisation SQL..."
/entrypoint/generate_init_sql.sh

echo "Configuration des permissions..."
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

echo "Démarrage de MariaDB avec fichier d'initialisation..."
exec mysqld --defaults-file=/etc/mysql/my.cnf --user=mysql --init-file=/docker-entrypoint-initdb.d/init.sql
