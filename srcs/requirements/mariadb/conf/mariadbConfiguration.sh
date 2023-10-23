#!/bin/bash

set -e

echo -e "Start MySQL service..."
service mysql start
echo -e "\e[32m[MySQL service started]\e[0m"

# Safe install of MySQL
if [ ! -d "/var/lib/mysql/$WP_TITLE" ]; then
	echo "[First MySQL configuration]"

	echo -e "mysql_secure_installation..."
	mysql_secure_installation << EOF

	n
	y
	y
	y
	y
EOF
	echo -e "\e[32m[MySQL Installed]\e[0m"

	echo -e "Creating databases..."
	mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $WP_TITLE;"
	mysql -uroot -e "CREATE USER IF NOT EXISTS '$WP_USER_LOGIN'@'%' IDENTIFIED BY '$WP_USER_PASSWORD';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON $WP_TITLE.* TO '$WP_USER_LOGIN'@'%';"
	mysql -uroot -e "FLUSH PRIVILEGES;"
	mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	echo -e "\e[32m[Databases created]\e[0m"
fi

echo -e "\e[32m[Restarting MySQL]\e[0m"
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

exec "$@"
