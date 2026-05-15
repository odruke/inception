#!/bin/bash


if [ ! -f dbcreated.flag ]; then
	mysqld_safe &

	while ! mysqladmin ping --silent; do
		sleep 1
	done

	sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mysql -e "FLUSH PRIVILEGES;"

	touch dbcreated.flag
	mysqladmin shutdown
fi

exec mysqld_safe