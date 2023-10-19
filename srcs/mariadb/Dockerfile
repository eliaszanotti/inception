# Build:	sudo docker build -t mariadb .
# Run:		sudo docker run -it mariadb
FROM	debian:buster

# Expose ports
EXPOSE	3306

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y mariadb-server

# Configure mariadb
COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Add scripts
COPY	scripts/databaseCreationScript.sh .
RUN		chmod +x databaseCreationScript.sh

# Run mariadb script
ENTRYPOINT	["./databaseCreationScript.sh"]
CMD		["mysqld", "--bind-address=0.0.0.0"]