FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Copy configuration file
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY /tools/script.sh .

# Copy the script into the Docker image
COPY tools/script.sh ./tools/

# Set execute permission on the script
RUN chmod +x ./tools/script.sh

# # Expose port
# EXPOSE 3306

# # # Start MariaDB server
# CMD ["bash"]

CMD ["/bin/bash", "./tools/script.sh"]


# CMD ["./tools/script.sh"]

# script.sh