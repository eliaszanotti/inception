#!/bin/bash
set -e

echo -e "Start MySQL service..."
service mysql start
echo -e "\e[32m[MySQL service started]\e[0m"

# Safe install of MySQL
if [ ! -d "/var/lib/mysql/$SQL_DB_NAME" ]; then
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
	mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $SQL_DB_NAME;"
	mysql -uroot -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_USER_PASSWORD';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON $SQL_DB_NAME.* TO '$SQL_USER'@'%';"
	mysql -uroot -e "FLUSH PRIVILEGES;"
	mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
	echo -e "\e[32m[Databases created]\e[0m"
fi

echo -e "\e[32m[Restarting MySQL]\e[0m"
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

exec "$@"
