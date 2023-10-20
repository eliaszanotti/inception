#!/bin/bash
# set -e

echo -e "Giving privileges..."
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;
echo -e "\e[32m[Privileges gived]\e[0m"

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "[First WordPress configuration]"

	echo -e "Obtaining secret keys (WordPress API)..."
	wp_keys=$(curl -s "https://api.wordpress.org/secret-key/1.1/salt/")
	echo -e "\e[32m[API Secret keys obtained]\e[0m"

	# Download WordPress
	mkdir -p /var/www/wordpress
	cd /var/www/wordpress
	wp core download --allow-root

	# Create wp-config.php
    wp config create	--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb:3306 \
						--path="/var/www/wordpress" \
						--dbcharset="utf8" \
						--dbcollate="utf8_general_ci" \
						--allow-root
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    # wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
    # wp theme install inspiro --activate --allow-root

fi

echo -e "\e[32m[WordPress started on :9000]\e[0m"