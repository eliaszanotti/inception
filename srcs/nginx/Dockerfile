# Build: sudo docker build -t nginx .
# Run:   sudo docker run -it nginx
FROM	debian:buster

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y nginx
RUN		apt-get install -y openssl

# Create SSL certificate
RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes \
		-out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key \
		-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ezanotti.42.fr/UID=ezanotti"

# Configure nginx
RUN		mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf
# Copy nginx config

RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html
COPY	conf/index.html /var/www/html/index.html

CMD		["nginx", "-g", "daemon off;"]