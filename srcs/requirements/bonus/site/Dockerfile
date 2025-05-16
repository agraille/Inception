FROM alpine:3.20.6

RUN apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY page/ /var/www/html/

RUN chown -R nginx:nginx /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
