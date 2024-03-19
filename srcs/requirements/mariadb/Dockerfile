FROM debian:bullseye

# Set environment variables
ENV SQL_DATABASE=mydatabase \
    SQL_USER=myuser \
    SQL_PASSWORD=mypassword \
    SQL_ROOT_PASSWORD=myrootpassword

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Copy configuration file
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the script into the Docker image
COPY tools/script.sh /tools/

# Set execute permission on the script
RUN chmod +x /tools/script.sh

# # Expose port
# EXPOSE 3306

# # # Start MariaDB server
CMD ["./tools/script.sh"]
