FROM debian:bookworm

RUN apt-get update -y \
&& apt-get install mariadb-server -y \
&& apt install vim -y \
&& apt-get clean

COPY tools/.vimrc /root/.vimrc
COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["./init.sh"]
