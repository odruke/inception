#!/bin/sh
set -eu

: "${DOMAIN_NAME:?DOMAIN_NAME is not set}"

sed "s|__DOMAIN_NAME__|${DOMAIN_NAME}|g" /etc/nginx/templates/default.template \
  > /etc/nginx/sites-available/default

exec nginx -g 'daemon off;'
