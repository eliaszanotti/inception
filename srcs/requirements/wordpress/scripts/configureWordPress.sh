#!/bin/bash

echo -e "Giving privileges..."
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;
echo -e "\e[32m[Privileges gived]\e[0m"

if [ ! -f /var/www/html/wp-config.php ]; then
	echo -e "\e[32m[First WordPress configuration]\e[0m"

	echo -e "Downloading WordPress..."
	mkdir -p /var/www/html
	cd /var/www/html
	wp core download 	--allow-root
	echo -e "\e[32m[WordPress downloaded]\e[0m"

	echo -e "Creating wp-config.php..."
    wp config create	--dbname=${WP_TITLE} \
						--dbuser=${WP_USER_LOGIN} \
						--dbpass=${WP_USER_PASSWORD} \
						--dbhost=mariadb:3306 \
						--path="/var/www/html" \
						--dbcharset="utf8" \
						--dbcollate="utf8_general_ci" \
						--allow-root
	echo -e "\e[32m[wp-config.php created]\e[0m"

	echo -e "Installing WordPress..."
	wp core install		--url=${WP_URL} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN_LOGIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--skip-email \
						--allow-root
	echo -e "\e[32m[WordPress installed]\e[0m"

	echo -e "Creating WordPress user..."
	wp user create		--allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD}
	echo -e "\e[32m[WordPress user created]\e[0m"
fi

echo -e "\e[32m[WordPress started on :9000]\e[0m"

exec "$@"