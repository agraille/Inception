FROM alpine:3.20.6

RUN apk add --no-cache curl tar && \
    curl -LO https://dl.grafana.com/oss/release/grafana-10.4.1.linux-amd64.tar.gz && \
    tar -zxvf grafana-10.4.1.linux-amd64.tar.gz && \
    ls -l && \
    mv grafana-v10.4.1 /etc/grafana && \
    rm grafana-10.4.1.linux-amd64.tar.gz

WORKDIR /etc/grafana
EXPOSE 3000

CMD ["/etc/grafana/bin/grafana-server", "--homepath=/etc/grafana"]

# http://prometheus:9090
# 193 dashboard 10619
