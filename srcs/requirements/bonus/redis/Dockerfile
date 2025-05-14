FROM alpine:3.18

RUN apk update && apk add --no-cache redis bash

COPY /conf/redis.conf /etc/redis.conf

RUN mkdir -p /data && chown redis:redis /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
