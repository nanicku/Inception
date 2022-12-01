#!/bin/sh

if [ ! -e wp-config.php ]; then
	wp core download --force --allow-root
	sleep 10
	wp config create --allow-root \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PSW} \
		--dbhost=${DB_HOST}
	wp core install --allow-root \
		--url=${DOMAIN_NAME} \
		--url=localhost \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL}
	wp user create --allow-root \
		${WP_USER} \
		${WP_USER_EMAIL} \
		--role=subscriber \
		--user_pass=${WP_USER_PASSWORD}
	wp theme install inspiro --activate --allow-root
		sed -i "40i define( 'WP_REDIS_HOST', 'redis' );"      wp-config.php
    	sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
    	sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
    	sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
    	sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php
		sed -i "40i define('FS_METHOD','direct');"      wp-config.php
		sed -i "41i define( 'WP_DEBUG', false );"      wp-config.php
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
echo "Wordpress: set up!"
else
echo "Wordpress: is already set up!"
fi

wp redis enable --allow-root
chmod -R 777 wp-content/
mkdir -p /run/php
php-fpm7.3 --nodaemonize