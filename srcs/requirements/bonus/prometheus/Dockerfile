FROM alpine:3.20.6

RUN apk add --no-cache curl tar gzip

RUN adduser -D -g '' prometheus

ENV PROM_VERSION=2.51.1

RUN curl -LO https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz && \
    tar -xzf prometheus-${PROM_VERSION}.linux-amd64.tar.gz && \
    mv prometheus-${PROM_VERSION}.linux-amd64 /etc/prometheus && \
    rm prometheus-${PROM_VERSION}.linux-amd64.tar.gz

COPY conf/prometheus.yml /etc/prometheus/

RUN mkdir -p /prometheus && chown -R prometheus:prometheus /prometheus

USER prometheus

EXPOSE 9090

WORKDIR /etc/prometheus

CMD ["./prometheus", "--config.file=prometheus.yml", "--storage.tsdb.path=/prometheus"]
