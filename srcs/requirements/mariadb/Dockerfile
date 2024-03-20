# Build:	sudo docker build -t mariadb .
# Run:		sudo docker run -it mariadb
FROM	debian:bullseye

# Expose ports
EXPOSE	3306

# Install services
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y mariadb-server

# Arguments
ARG     SQL_DB_NAME
ARG     SQL_USER
ARG     SQL_USER_PASSWORD
ARG     SQL_ROOT_PASSWORD

# MariaDB configuration
RUN     service mariadb start && mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DB_NAME}; \
												CREATE  USER IF NOT EXISTS ${SQL_USER}@'localhost' IDENTIFIED BY '${SQL_USER_PASSWORD}'; \
												GRANT ALL PRIVILEGES ON ${SQL_DB_NAME}.* TO ${SQL_USER}@'%' IDENTIFIED BY '${SQL_USER_PASSWORD}'; \
 												ALTER USER 'root'@localhost IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; \
 												FLUSH PRIVILEGES;"

CMD		["mysqld", "--bind-address=0.0.0.0"]