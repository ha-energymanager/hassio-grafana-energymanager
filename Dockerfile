ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache grafana nginx

COPY rootfs/ /

RUN chmod +x /etc/services.d/grafana/run \
    && chmod +x /etc/services.d/nginx/run
