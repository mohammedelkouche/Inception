#!/bin/bash

# Start MySQL service

#--------- work --------
service mariadb start
# service mariadb restart

# Wait for MySQL to start
sleep 5

# Create database
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# Create user
mysql -e "CREATE USER IF NOT EXISTS ${SQL_USER}@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant privileges to user
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO ${SQL_USER}@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modify root user privileges
mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Flush privileges
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shutdown MySQL
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Restart MySQL
exec mysqld_safe