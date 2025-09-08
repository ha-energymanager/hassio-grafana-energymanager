ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache grafana nginx tini

# configs
COPY rootfs/ /

COPY dashboards/ /usr/share/grafana/default-dashboards/

# your supervisor script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# no s6: use tini as PID 1
ENTRYPOINT ["/sbin/tini","-g","--"]
CMD ["/run.sh"]
