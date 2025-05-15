FROM alpine:latest

RUN apk update && apk add vsftpd shadow bash

RUN mkdir -p /etc/vsftpd /var/run/vsftpd /var/www/wordpress

RUN adduser -D -h /var/www/wordpress ftpuser && echo "ftpuser:ftppass" | chpasswd

RUN usermod -d /var/www/wordpress ftpuser

RUN chown -R ftpuser:ftpuser /var/www/wordpress
RUN chmod 755 /var/www/wordpress

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21
EXPOSE 30000-30100

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
