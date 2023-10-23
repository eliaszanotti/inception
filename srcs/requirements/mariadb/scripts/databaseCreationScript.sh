#!/bin/bash
# set -e

# Start the mysql daemon in the background
echo -e "\e[31mSTARTING MYSQL DAEMON\e[0m"
service mysql start
	
# SQL_DATABASE="wordpress"
# SQL_ROOT_PASSWORD="root"
if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]; then
	
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	
	# Create the wordpress database
	echo "ok"
	mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '\`${SQL_ROOT_PASSWORD}\`';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '\`${SQL_ROOT_PASSWORD}\`';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '\`${SQL_ROOT_PASSWORD}\`';"
	mysql -e "FLUSH PRIVILEGES;"
	
fi

# Shutdown the mysql daemon
echo "- - - - - - - - - - - Shutting down mysql daemon"
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
echo "----------------------Shutting down mysql daemon"

# Restart all the services
exec mysqld_safe