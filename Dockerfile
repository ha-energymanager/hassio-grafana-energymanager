ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache grafana nginx

COPY rootfs/ /

RUN test -x /init || (echo "ERROR: /init missing (no s6-overlay in base image)"; exit 1)
RUN { test -x /command/with-contenv || test -x /usr/bin/with-contenv; } \
  || (echo "ERROR: with-contenv wrapper missing (path mismatch)"; exit 1)

RUN chmod +x /etc/services.d/grafana/run \
    && chmod +x /etc/services.d/nginx/run
