#!/bin/sh
set -e

mkdir -p /data/grafana/log /data/grafana/plugins /data/dashboards
chown -R grafana:grafana /data/grafana /data/dashboards || true

if [ -d /usr/share/grafana/default-dashboards ] && [ -z "$(ls -A /data/dashboards 2>/dev/null)" ]; then
  cp -a /usr/share/grafana/default-dashboards/*.json /data/dashboards/ 2>/dev/null || true
fi

grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini &
GRAF=$!

nginx -c /etc/nginx/nginx.conf -g "daemon off;" &
NGINX=$!

term() {
  kill -TERM "$GRAF" "$NGINX" 2>/dev/null || true
  wait "$GRAF" "$NGINX" 2>/dev/null || true
}
trap term INT TERM

wait -n
term
