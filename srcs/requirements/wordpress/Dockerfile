FROM debian:bullseye


RUN apt-get update

RUN apt-get -y install wget


RUN apt-get install -y php7.4 php-fpm php-mysql mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# Copy wp.sh script into the image
COPY ./tools/wp.sh ./tools/wp.sh 

# Make wp.sh executable
RUN chmod +x ./tools/wp.sh


# Start PHP-FPM
CMD ["./tools/wp.sh"]