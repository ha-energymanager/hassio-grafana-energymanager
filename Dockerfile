ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:14.2.2
FROM $BUILD_FROM

RUN apk add --no-cache grafana nginx

COPY rootfs/ /

RUN chmod +x /etc/services.d/grafana/run \
    && chmod +x /etc/services.d/nginx/run
