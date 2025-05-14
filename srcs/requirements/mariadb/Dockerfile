FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client bash

# #fix for alpine
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/generate_init_sql.sh /entrypoint/generate_init_sql.sh
COPY tools/entrypoint.sh /entrypoint/entrypoint.sh

RUN mkdir -p /docker-entrypoint-initdb.d
RUN chmod +x /entrypoint/entrypoint.sh /entrypoint/generate_init_sql.sh

RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

EXPOSE 3306

CMD ["/entrypoint/entrypoint.sh"]
