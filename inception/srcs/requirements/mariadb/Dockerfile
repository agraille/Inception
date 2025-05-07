FROM alpine:3.18

#instal package 
RUN apk update && apk add --no-cache mariadb mariadb-client bash

#config copy
COPY conf/50-server.cnf /etc/my.cnf.d/50-server.cnf

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
