# Version
FROM	debian:buster

# Open port
EXPOSE		443

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y nginx
RUN		apt-get install -y openssl

# Copy data to the docker env
COPY	./conf/nginx.conf /etc/nginx/sites-enabled/default

# Launch the configuration of Nginx
COPY	./scripts/nginx_start.sh /var/www
RUN		chmod +x /var/www/nginx_start.sh
ENTRYPOINT	["/var/www/nginx_start.sh"]

# Execute Nginx
CMD		["nginx", "-g", "daemon off;"]