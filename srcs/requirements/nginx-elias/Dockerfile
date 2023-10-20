# Build:	sudo docker build -t nginx .
# Run:		sudo docker run -it -p 433:433 nginx
FROM	debian:buster

# Expose ports
EXPOSE	443

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y nginx
RUN		apt-get install -y openssl

# Create SSL certificate
RUN		mkdir -p /etc/nginx/ssl
RUN	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt \
	-subj "/C=FR/L=Lyon/O=42/OU=lpupier/CN=lpupier.42.fr"

# RUN		openssl req -x509 -nodes \
# 		-out /etc/nginx/ssl/inception.crt \
# 		-keyout /etc/nginx/ssl/inception.key \
# 		-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ezanotti.42.fr/UID=ezanotti"

# Configure nginx
RUN		mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# TODO : remove this line
COPY	conf/index.html /var/www/html/index.html
COPY	conf/test.php /var/www/html/test.php

CMD		["nginx", "-g", "daemon off;"]