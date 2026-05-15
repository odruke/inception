#!/bin/bash

while ! mysqladmin ping -h mariadb --silent; do
    sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then

    cd /var/www/html

    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* .
    rm -rf wordpress latest.tar.gz

    wp config create \
        --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb

    wp core install \
        --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_USER \
        --admin_password=$WP_USER_PASSWORD \
        --admin_email=$WP_USER_EMAIL

    chown -R www-data:www-data /var/www/html
fi

exec php-fpm7.4 -F