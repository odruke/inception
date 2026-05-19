FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y vim nginx openssl\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/nginx

COPY ssl/inception.crt /etc/nginx/ssl/inception.crt
COPY ssl/inception.key /etc/nginx/ssl/inception.key

COPY tools/.vimrc /root/.vimrc


COPY conf/default.template /etc/nginx/templates/default.template
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
