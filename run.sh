#!/bin/sh
set -e

# start grafana
grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini &
GRAF=$!

# start nginx in foreground
nginx -c /etc/nginx/nginx.conf -g "daemon off;" &
NGINX=$!

term() {
  kill -TERM "$GRAF" "$NGINX" 2>/dev/null || true
  wait "$GRAF" "$NGINX" 2>/dev/null || true
}
trap term INT TERM

# wait on either; then cleanly stop the other
wait -n
term
