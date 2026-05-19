#!/bin/bash
set -e

DATA_DIR=/var/lib/mysql
SOCKET=/run/mysqld/mysqld.sock

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld "$DATA_DIR"

# Allow external connections (applies to the final startup)
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize base system tables if this is a fresh volume.
if [ ! -d "$DATA_DIR/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mariadb-install-db --user=mysql --datadir="$DATA_DIR"
fi

# Use the database folder as the proof of configuration.
if [ ! -d "$DATA_DIR/$DB_NAME" ]; then
  echo "Configuring initial database and user..."
  mysqld_safe --skip-networking --socket="$SOCKET" &
  TMP_PID=$!


# wait for socket (timeout to avoid endless loop)
max_attempts=60
attempt=0

  until mysqladmin --socket="$SOCKET" ping --silent; do
      attempt=$((attempt + 1))
    if [ "$attempt" -ge "$max_attempts" ]; then
      echo "Error: socket did not become ready after ${max_attempts}s."
      exit 1
    fi
    sleep 1
  done

  mysql --socket="$SOCKET" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
  mysql --socket="$SOCKET" -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
  mysql --socket="$SOCKET" -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
  mysql --socket="$SOCKET" -e "FLUSH PRIVILEGES;"

  mysqladmin --socket="$SOCKET" shutdown
  wait "$TMP_PID"
fi

echo "Starting MariaDB..."
exec mysqld_safe
