#!/bin/bash

sleep 10

mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

wp config set --allow-root DB_NAME ${SQL_DATABASE} --path='/var/www/wordpress'
wp config set --allow-root DB_USER ${SQL_USER} --path='/var/www/wordpress'
wp config set --allow-root DB_PASSWORD ${SQL_PASSWORD} --path='/var/www/wordpress'
wp config set --allow-root DB_HOST 'mariadb:3306' --path='/var/www/wordpress'
wp core install --allow-root --url="${WEBSITE}" --title="${TITLE}" --admin_user="${WP_USER_ADMIN}" --admin_password="${WP_PASSWORD_ADMIN}" \
    --admin_email="${MAIL_ADMIN}" --skip-email --path='/var/www/wordpress'

wp user create --allow-root "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASS}" --path='/var/www/wordpress'

# Ensure the PHP-FPM PID file directory exists
mkdir -p /run/php

# Start php-fpm
/usr/sbin/php-fpm7.4 -F