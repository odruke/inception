FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl wget gnupg2 ca-certificates mariadb-client\
    php php-cli php-fpm php-mysql \
    php-curl php-xml php-mbstring php-zip unzip \
    vim \
  && apt-get clean

COPY tools/.vimrc /root/.vimrc
COPY tools/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Install WP-CLI
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

ENTRYPOINT ["/init.sh"]