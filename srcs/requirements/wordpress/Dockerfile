# Build:	sudo docker build -t wordpress .
# Run:		sudo docker run -it wordpress
FROM	debian:bullseye

# Expose ports
EXPOSE	9000

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y wget
RUN		apt-get install -y curl

# Install PHP
RUN		apt-get install -y php7.4
RUN		apt-get install -y php-fpm
RUN		apt-get install -y php-mysql
RUN		apt-get install -y mariadb-client

# Install WordPress CLI
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar
RUN		cp wp-cli.phar /usr/bin/wp		

# Configure PHP
COPY	conf/www.conf /etc/php/7.4/fpm/pool.d

# WordPress configuration
COPY	scripts/configureWordPress.sh .
RUN		chmod +x configureWordPress.sh
ENTRYPOINT ["./configureWordPress.sh"]

CMD		["/usr/sbin/php-fpm7.4", "--nodaemonize"]