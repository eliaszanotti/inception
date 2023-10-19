#!/bin/bash
set -e

# Start the mysql daemon in the background
service mysql start;

# Create the wordpress database
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '\`${SQL_PASSWORD}\`';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '\`${SQL_PASSWORD}\`';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '\`${SQL_ROOT_PASSWORD}\`';"
mysql -e "FLUSH PRIVILEGES;"

# Shutdown the mysql daemon
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Restart all the services
exec mysqld_safe