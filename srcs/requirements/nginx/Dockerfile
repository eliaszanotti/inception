# Version
FROM	debian:bullseye

# Open port
EXPOSE	443

# Install dependencies
RUN		apt-get update -y
RUN		apt-get upgrade -y
RUN		apt-get install -y nginx
RUN		apt-get install -y openssl

# Copy data to the docker env
COPY	./conf/nginx.conf /etc/nginx/sites-enabled/default

# Generate SSL certificate
RUN		openssl req	-x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt \
		-subj "/C=FR/L=Lyon/O=42/OU=ezanotti/CN=ezanotti.42.fr"
RUN		exec "$@"

# Execute Nginx
CMD		["nginx", "-g", "daemon off;"]