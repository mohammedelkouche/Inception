#!/bin/bash

sleep 10

#-------1 ---------
# Modify the listen directive
sed -i 's|^listen =.*|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Add clear_env directive
echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

wp config set --allow-root DB_NAME ${SQL_DATABASE} --path='/var/www/wordpress'
wp config set --allow-root DB_USER ${SQL_USER} --path='/var/www/wordpress'
wp config set --allow-root DB_PASSWORD ${SQL_PASSWORD} --path='/var/www/wordpress'
wp config set --allow-root DB_HOST 'mariadb:3306' --path='/var/www/wordpress'
#--------------- 0 -------------------

#-------------------------------------------------------------------

# wp config create --allow-root --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" \
#     --dbhost=mariadb:3306 --path='/var/www/wordpress'
#----------------
                # --admin_email="admin@example.com"
#----------------
# wp core install --allow-root --url="http://your-domain.com" --title="Your Site Title" --admin_user="$SQL_USER" --admin_password="$SQL_PASSWORD"
#----------------
# wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAI --allow-root --path=/var/www/html

#---------------------------------------------------------------------

wp core install --allow-root --url="https://mel-kouc.42.fr" --title="Your Site Title" --admin_user=${SQL_USER} --admin_password=${SQL_PASSWORD} \
    --admin_email="domain@gmai.com" --skip-email --path='/var/www/wordpress'


# Optionally, create additional WordPress users
# wp user create --allow-root
#                username
#                user@example.com
#                --user_pass=password

# Ensure the PHP-FPM PID file directory exists
mkdir -p /run/php

# Start php-fpm
/usr/sbin/php-fpm7.4 -F

##------------ 1 -------------


# #---------- 2 -----------

# # Print out database connection parameters
# echo "SQL_DATABASE: $SQL_DATABASE"
# echo "SQL_USER: $SQL_USER"
# echo "SQL_PASSWORD: $SQL_PASSWORD"

# # Use IP address of MariaDB container as the database host
# DB_HOST="172.20.0.2"

# # Create WordPress configuration
# wp config create --allow-root --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" \
#     --dbhost="$DB_HOST:3306" --path='/var/www/wordpress'

# # Print out WordPress configuration details
# echo "WordPress configuration created."

# # Install WordPress
# wp core install --allow-root --url="http://your-domain.com" --title="Your Site Title" --admin_user="$SQL_USER" --admin_password="$SQL_PASSWORD"

# # Print out installation status
# echo "WordPress installation completed."

# # Ensure the PHP-FPM PID file directory exists
# mkdir -p /run/php/

# # Start php-fpm
# echo "Starting PHP-FPM..."
# /usr/sbin/php-fpm7.4 -F

#------------ 2 ------------------


#--------------- 3 -----------------

# sleep 6

# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# mkdir /run/php

# cd /var/www/html && wp core download --allow-root
 
# mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

# wp config set DB_NAME $SQL_DATABASE --allow-root --path=/var/www/html
# wp config set DB_USER $SQL_USER --allow-root --path=/var/www/html
# wp config set DB_PASSWORD $SQL_PASSWORD --allow-root --path=/var/www/html
# wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

# wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html

# # wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root --path=/var/www/html

# /usr/sbin/php-fpm7.4 -F
#--------------------------------