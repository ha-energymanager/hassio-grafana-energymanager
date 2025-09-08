ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache grafana nginx

COPY rootfs/ /

RUN test -x /init || (echo "ERROR: /init missing (no s6-overlay in base image)"; exit 1)
RUN test -x /command/with-contenv || (echo "ERROR: /command/with-contenv missing (wrong s6 path for v3)"; ls -l /command || true; exit 1)
RUN /init --version || true

RUN chmod +x /etc/services.d/grafana/run \
    && chmod +x /etc/services.d/nginx/run
