#!/bin/bash
set -e

# wait for mariadb
until mysqladmin ping -h mariadb --silent; do
  sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then
  mkdir -p /var/www/html
  chown www-data:www-data /var/www/html
  cd /var/www/html

  curl -O https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  mv wordpress/* .
  rm -rf wordpress latest.tar.gz

  if command -v wp >/dev/null 2>&1; then
    wp config create \
    --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="mariadb"

    wp core install \
    --allow-root \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_USER" \
    --admin_password="$WP_USER_PASSWORD" \
    --admin_email="$WP_USER_EMAIL"
  else
    cat > wp-config.php <<EOF
<?php
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
EOF
  fi

  chown -R www-data:www-data /var/www/html
fi

exec php-fpm -F
