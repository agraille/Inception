#!/bin/sh

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)

mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD"
