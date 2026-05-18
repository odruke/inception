FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y vim nginx openssl\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/nginx

COPY ssl/inception.crt /etc/nginx/ssl/inception.crt
COPY ssl/inception.key /etc/nginx/ssl/inception.key

COPY tools/.vimrc /root/.vimrc

COPY conf/default /etc/nginx/sites-available/default

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
