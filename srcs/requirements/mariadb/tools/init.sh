#!/bin/bash


if [ ! -f dbcreated.flag ]; then
	exec mysqld_safe

	while ! mysqladmin ping --silent; do
		sleep 1
	done
	echo "editing ip from 50-server.cnf"
	sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

	echo "Database does not exists, creating database: ${DB_NAME}"
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mysql -e "FLUSH PRIVILEGES;"

	touch dbcreated.flag
	# mysqladmin shutdown

else
	echo "Database already exists, launching mysqld_safe"
	exec mysqld_safe
fi
