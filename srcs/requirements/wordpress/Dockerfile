FROM debian:bookworm

RUN apt-get update \
    && apt install vim -y \
    && apt-get install -y \
    mariadb-client \
    php \
    php-fpm \
    php-mysql \
    curl

COPY /tools/.vimrc /root/.vimrc
COPY tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]