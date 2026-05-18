#!/bin/bash
set -e

# wait for mariadb

until mysqladmin ping -h mariadb --silent; do
  sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then

  echo "wordpress not installed, downloading and installing..."

  mkdir -p /var/www/html
  chown www-data:www-data /var/www/html
  cd /var/www/html

  tmpdir=$(mktemp -d)
  curl -o "$tmpdir/latest.tar.gz" https://wordpress.org/latest.tar.gz
  tar -xzf "$tmpdir/latest.tar.gz" -C "$tmpdir"
  # copy contents into target, merging with existing directories
  shopt -s dotglob
  cp -a "$tmpdir/wordpress/." /var/www/html/
  shopt -u dotglob
  rm -rf "$tmpdir"

    echo "configuring wordpress database..."
    wp config create \
    --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="mariadb"

    # wp core install \
    # --allow-root \
    # --url="$DOMAIN_NAME" \
    # --title="$WP_TITLE" \
    # --admin_user="$WP_USER" \
    # --admin_password="$WP_USER_PASSWORD" \
    # --admin_email="$WP_USER_EMAIL"
    

  chown -R www-data:www-data /var/www/html
fi

echo "launching php-fpm"

exec php-fpm8.2 -F
