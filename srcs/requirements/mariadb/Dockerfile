# Build:	sudo docker build -t mariadb .
# Run:		sudo docker run -it mariadb
FROM	debian:buster

# Expose ports
EXPOSE	3306

# Install services
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y mariadb-server

# MariaDB configuration
COPY	conf/mariadbConfiguration.sh .
RUN		chmod +x mariadbConfiguration.sh

# Start
ENTRYPOINT	["./mariadbConfiguration.sh"]
CMD		["mysqld", "--bind-address=0.0.0.0"]