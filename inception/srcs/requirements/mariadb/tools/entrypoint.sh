#!/bin/bash

mkdir -p /docker-entrypoint-initdb.d
chmod -R 755 /docker-entrypoint-initdb.d

/entrypoint/generate_init_sql.sh

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

exec mysqld --user=mysql --init-file=/docker-entrypoint-initdb.d/init.sql
